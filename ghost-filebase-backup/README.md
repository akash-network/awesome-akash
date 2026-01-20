# Ghost with Filebase Backup

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ghost-filebase-backup)


Deploy Ghost blog on Akash with automatic IPFS backup via Filebase.

在 Akash 上部署 Ghost 博客，通过 Filebase 实现自动 IPFS 备份。

[English Version](#english-version) | [中文版本](#中文版本)

---

# 中文版本

## 目录

- [概述](#概述)
- [文件结构](#文件结构)
- [详细配置说明](#详细配置说明)
  - [Version 版本](#version-版本)
  - [Services 服务配置](#services-服务配置)
  - [Profiles 资源配置](#profiles-资源配置)
  - [Deployment 部署配置](#deployment-部署配置)
- [环境变量详解](#环境变量详解)
- [使用步骤](#使用步骤)
- [常见问题](#常见问题)

## 概述

`deploy.yaml` 是一个 Akash 网络的 SDL（Stack Definition Language）部署配置文件。它用于在 Akash 去中心化云平台上部署 Ghost 博客系统，并集成 Filebase/IPFS 存储备份功能。

**主要功能：**
- 部署 Ghost 博客系统
- 自动备份数据到 Filebase（基于 IPFS 的 S3 兼容存储）
- 支持加密备份
- 可选的邮件服务配置

## 文件结构

```yaml
---
version: "2.0"           # SDL 版本

services:                # 服务定义
  ghost:                 # 服务名称
    image: ...           # Docker 镜像
    expose: ...          # 端口暴露配置
    env: ...             # 环境变量

profiles:                # 配置文件
  compute:               # 计算资源
  placement:             # 放置和定价

deployment:              # 部署配置
  ghost:
    akash:
      profile: ghost
      count: 1
```

## 详细配置说明

### Version 版本

```yaml
version: "2.0"
```

指定 Akash SDL 规范版本。目前推荐使用 `2.0` 版本。

### Services 服务配置

#### image 镜像

```yaml
image: ghcr.io/zhajingwen/ghost-ipfs-bkup:latest
```

Docker 镜像地址，包含预配置的 Ghost 博客系统和备份功能。

#### expose 端口暴露

```yaml
expose:
  - port: 2368        # Ghost 内部端口
    as: 80            # 对外暴露为 80 端口
    to:
      - global: true  # 允许全局访问
    accept:
      - changeme.com  # 接受的域名（需要修改）
```

| 参数 | 说明 |
|------|------|
| `port` | Ghost 容器内部运行端口（默认 2368） |
| `as` | 对外暴露的端口（使用 80 作为 HTTP 标准端口） |
| `global: true` | 允许来自互联网的全局访问 |
| `accept` | 允许访问的域名列表，需替换为您的实际域名 |

### Profiles 资源配置

#### compute 计算资源

```yaml
profiles:
  compute:
    ghost:
      resources:
        cpu:
          units: 0.5      # CPU 核心数
        memory:
          size: 512Mi     # 内存大小
        storage:
          size: 1.5Gi     # 存储空间
```

| 资源 | 值 | 说明 |
|------|------|------|
| CPU | 0.5 units | 半个 CPU 核心 |
| 内存 | 512Mi | 512 MB 内存 |
| 存储 | 1.5Gi | 1.5 GB 存储空间 |

> **注意：** 可根据实际需求调整资源配置。更大的博客可能需要更多资源。

#### placement 放置和定价

```yaml
placement:
  akash:
    pricing:
      ghost:
        denom: uakt      # 代币单位（微 AKT）
        amount: 5000     # 愿意支付的最高价格
```

| 参数 | 说明 |
|------|------|
| `denom` | 代币单位，`uakt` = 1/1,000,000 AKT |
| `amount` | 每区块愿意支付的最高 uAKT 数量 |

### Deployment 部署配置

```yaml
deployment:
  ghost:
    akash:
      profile: ghost   # 使用的配置文件名称
      count: 1         # 部署实例数量
```

## 环境变量详解

### 必填变量

| 变量名 | 示例值 | 说明 |
|--------|--------|------|
| `url` | `http://yourdomain.com` | Ghost 博客的访问 URL，必须与 `accept` 中的域名一致 |
| `NODE_ENV` | `production` | 运行环境，生产环境使用 `production` |
| `FILEBASE_BUCKET` | `my-ghost-backup` | Filebase 存储桶名称 |
| `FILEBASE_ENDPOINT` | `https://s3.filebase.com` | Filebase S3 端点地址 |
| `FILEBASE_ACCESS_KEY_ID` | `your-access-key` | Filebase 访问密钥 ID |
| `FILEBASE_SECRET_ACCESS_KEY` | `your-secret-key` | Filebase 秘密访问密钥 |
| `BACKUP_ENCRYPTION_PASSWORD` | `strong-password` | 数据库备份加密密码 |

### 可选变量

| 变量名 | 示例值 | 说明 |
|--------|--------|------|
| `FILEBASE_BACKUP_PATH` | `my-backup` | 备份目录路径前缀 |

**备份路径说明：**
- 未设置时：备份存储在 `s3://bucket/images` 和 `s3://bucket/data`
- 设置为 `my-backup` 时：备份存储在 `s3://bucket/my-backup/images` 和 `s3://bucket/my-backup/data`

### 邮件服务配置（可选）

Ghost 使用双下划线 (`__`) 作为嵌套配置的分隔符。

**Resend 邮件服务示例：**

```yaml
env:
  - mail__transport=SMTP
  - mail__options__host=smtp.resend.com
  - mail__options__port=587
  - mail__options__secure=false
  - mail__options__requireTLS=true
  - mail__options__auth__user=resend
  - mail__options__auth__pass=re_xxxxxxxxxxxxx
  - mail__from=noreply@resend.dev
```

## 使用步骤

### 步骤 1：准备 Filebase 账户

1. 访问 [Filebase](https://filebase.com) 注册账户
2. 创建一个新的存储桶（Bucket）
3. 获取访问密钥（Access Key ID 和 Secret Access Key）

### 步骤 2：修改配置文件

1. **修改域名**
   ```yaml
   accept:
     - yourdomain.com  # 替换为您的域名
   env:
     - url=http://yourdomain.com  # 替换为您的域名
   ```

2. **配置 Filebase**
   ```yaml
   env:
     - FILEBASE_BUCKET=your-bucket-name
     - FILEBASE_ACCESS_KEY_ID=your-access-key
     - FILEBASE_SECRET_ACCESS_KEY=your-secret-key
   ```

3. **生成加密密码**
   ```bash
   openssl rand -base64 32
   ```
   将生成的密码填入 `BACKUP_ENCRYPTION_PASSWORD`

### 步骤 3：部署到 Akash

1. 安装 Akash CLI 或使用 Akash Console
2. 创建部署证书
3. 提交部署配置
4. 选择提供商并确认

### 步骤 4：配置 DNS

将您的域名 DNS 指向 Akash 提供商分配的 URI。

## 常见问题

### Q: 如何调整资源配置？

修改 `profiles.compute.ghost.resources` 下的值。建议根据博客流量逐步调整。

### Q: 备份数据存储在哪里？

数据备份到 Filebase（IPFS 固定服务），可通过 S3 API 访问。

### Q: 为什么需要加密密码？

`BACKUP_ENCRYPTION_PASSWORD` 用于加密数据库备份，确保数据安全。请妥善保管此密码，丢失将无法恢复备份。

### Q: 邮件配置是必须的吗？

不是必须的，但如果不配置邮件服务，Ghost 的邮件相关功能（如密码重置、会员通知）将无法使用。

## 更多信息

如果您需要了解更多信息，请访问：https://github.com/zhajingwen/ghost-ipfs-bkup

---

# English Version

## Table of Contents

- [Overview](#overview)
- [File Structure](#file-structure-1)
- [Configuration Details](#configuration-details)
  - [Version](#version)
  - [Services Configuration](#services-configuration)
  - [Profiles Configuration](#profiles-configuration)
  - [Deployment Configuration](#deployment-configuration)
- [Environment Variables](#environment-variables)
- [Usage Steps](#usage-steps)
- [FAQ](#faq)

## Overview

`deploy.yaml` is an Akash Network SDL (Stack Definition Language) deployment configuration file. It is used to deploy the Ghost blogging system on the Akash decentralized cloud platform, with integrated Filebase/IPFS storage backup functionality.

**Key Features:**
- Deploy Ghost blogging system
- Automatic data backup to Filebase (IPFS-based S3-compatible storage)
- Encrypted backup support
- Optional email service configuration

## File Structure

```yaml
---
version: "2.0"           # SDL version

services:                # Service definitions
  ghost:                 # Service name
    image: ...           # Docker image
    expose: ...          # Port exposure config
    env: ...             # Environment variables

profiles:                # Profiles
  compute:               # Compute resources
  placement:             # Placement and pricing

deployment:              # Deployment config
  ghost:
    akash:
      profile: ghost
      count: 1
```

## Configuration Details

### Version

```yaml
version: "2.0"
```

Specifies the Akash SDL specification version. Version `2.0` is currently recommended.

### Services Configuration

#### image

```yaml
image: ghcr.io/zhajingwen/ghost-ipfs-bkup:latest
```

Docker image address containing the pre-configured Ghost blogging system with backup functionality.

#### expose - Port Exposure

```yaml
expose:
  - port: 2368        # Ghost internal port
    as: 80            # Exposed as port 80
    to:
      - global: true  # Allow global access
    accept:
      - changeme.com  # Accepted domain (needs modification)
```

| Parameter | Description |
|-----------|-------------|
| `port` | Ghost container internal port (default 2368) |
| `as` | Externally exposed port (80 for standard HTTP) |
| `global: true` | Allow global internet access |
| `accept` | List of allowed domains, replace with your actual domain |

### Profiles Configuration

#### compute - Compute Resources

```yaml
profiles:
  compute:
    ghost:
      resources:
        cpu:
          units: 0.5      # CPU cores
        memory:
          size: 512Mi     # Memory size
        storage:
          size: 1.5Gi     # Storage space
```

| Resource | Value | Description |
|----------|-------|-------------|
| CPU | 0.5 units | Half a CPU core |
| Memory | 512Mi | 512 MB memory |
| Storage | 1.5Gi | 1.5 GB storage space |

> **Note:** Adjust resource configuration based on actual needs. Larger blogs may require more resources.

#### placement - Placement and Pricing

```yaml
placement:
  akash:
    pricing:
      ghost:
        denom: uakt      # Token unit (micro AKT)
        amount: 5000     # Maximum price willing to pay
```

| Parameter | Description |
|-----------|-------------|
| `denom` | Token unit, `uakt` = 1/1,000,000 AKT |
| `amount` | Maximum uAKT per block willing to pay |

### Deployment Configuration

```yaml
deployment:
  ghost:
    akash:
      profile: ghost   # Profile name to use
      count: 1         # Number of instances to deploy
```

## Environment Variables

### Required Variables

| Variable | Example | Description |
|----------|---------|-------------|
| `url` | `http://yourdomain.com` | Ghost blog access URL, must match domain in `accept` |
| `NODE_ENV` | `production` | Runtime environment, use `production` for production |
| `FILEBASE_BUCKET` | `my-ghost-backup` | Filebase bucket name |
| `FILEBASE_ENDPOINT` | `https://s3.filebase.com` | Filebase S3 endpoint address |
| `FILEBASE_ACCESS_KEY_ID` | `your-access-key` | Filebase access key ID |
| `FILEBASE_SECRET_ACCESS_KEY` | `your-secret-key` | Filebase secret access key |
| `BACKUP_ENCRYPTION_PASSWORD` | `strong-password` | Database backup encryption password |

### Optional Variables

| Variable | Example | Description |
|----------|---------|-------------|
| `FILEBASE_BACKUP_PATH` | `my-backup` | Backup directory path prefix |

**Backup Path Explanation:**
- If not set: Backups stored at `s3://bucket/images` and `s3://bucket/data`
- If set to `my-backup`: Backups stored at `s3://bucket/my-backup/images` and `s3://bucket/my-backup/data`

### Email Service Configuration (Optional)

Ghost uses double underscores (`__`) as separators for nested configuration.

**Resend Email Service Example:**

```yaml
env:
  - mail__transport=SMTP
  - mail__options__host=smtp.resend.com
  - mail__options__port=587
  - mail__options__secure=false
  - mail__options__requireTLS=true
  - mail__options__auth__user=resend
  - mail__options__auth__pass=re_xxxxxxxxxxxxx
  - mail__from=noreply@resend.dev
```

## Usage Steps

### Step 1: Prepare Filebase Account

1. Visit [Filebase](https://filebase.com) to register an account
2. Create a new bucket
3. Obtain access keys (Access Key ID and Secret Access Key)

### Step 2: Modify Configuration File

1. **Modify Domain**
   ```yaml
   accept:
     - yourdomain.com  # Replace with your domain
   env:
     - url=http://yourdomain.com  # Replace with your domain
   ```

2. **Configure Filebase**
   ```yaml
   env:
     - FILEBASE_BUCKET=your-bucket-name
     - FILEBASE_ACCESS_KEY_ID=your-access-key
     - FILEBASE_SECRET_ACCESS_KEY=your-secret-key
   ```

3. **Generate Encryption Password**
   ```bash
   openssl rand -base64 32
   ```
   Use the generated password for `BACKUP_ENCRYPTION_PASSWORD`

### Step 3: Deploy to Akash

1. Install Akash CLI or use Akash Console
2. Create deployment certificate
3. Submit deployment configuration
4. Select provider and confirm

### Step 4: Configure DNS

Point your domain DNS to the URI assigned by the Akash provider.

## FAQ

### Q: How to adjust resource configuration?

Modify values under `profiles.compute.ghost.resources`. It's recommended to adjust gradually based on blog traffic.

### Q: Where is backup data stored?

Data is backed up to Filebase (IPFS pinning service), accessible via S3 API.

### Q: Why is encryption password needed?

`BACKUP_ENCRYPTION_PASSWORD` encrypts database backups for data security. Keep this password safe - losing it means you cannot restore backups.

### Q: Is email configuration required?

No, it's not required. However, without email service configuration, Ghost's email-related features (password reset, member notifications) won't work.

## More Information

For more information, please visit: https://github.com/zhajingwen/ghost-ipfs-bkup

---

## License

This documentation is provided as-is for the Ghost IPFS Backup project.
