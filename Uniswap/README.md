## 使用Akash DeCloud部署Uniswap

### 什么是AKash

根据官网介绍：Akash正在建立一个虚拟市场，让个人和组织实现无摩擦的云算力买卖的Airbnb市场：Airbnb平台能让用户出租闲置的房子，Akash平台则让用户出租闲置的算力。双方的直接接触大大拓展了已有的市场，让闲置的资源得以利用——出租方获得收益，租户获得更简便的体验。

目前世界上有大约840万个数据中心，其中85%服务器容量未被充分利用，Akash的去中心化云计算市场将如何彻底改变和重新定义云市场。

akash肯定有自己的优势：

- **去中心化：**Akash提供可信的执行环境，网络启动后，即使团队停止开发，用户仍然能正常使用Askah。
- **无需许可：**只需要按照标准接入市场，人人可自由出借算力获取收益，人人可按需借用算力。
- **成本更低：**Akash用户直接出价，供应商竞价获取该任务。买卖直接受供需关系影响，能提供更合理的价格。根据测试数据，**Akash的云计算成本比现有市场提供商（AWS、谷歌云、微软Azure和阿里云）低10倍。**

简而言之就是Akash是一个去中心化的云服务商，可以帮助我们以低成本像在AWS上部署应用一样部署一个去中心化应用。

### 部署Uniswap

首先根据Akash官方的[部署教程](https://docs.akash.network/v/master/guides/deploy)我们需要准备Docker镜像，关于Docker的简单安装和使用可以参考我以前写的[简单教程](https://www.jianshu.com/p/2614faa56cf6)。

**编译应用**

> 如果已经有Uniswap的Docker镜像可以先跳过这步。

首先从[Uniswap](https://github.com/Uniswap/uniswap-interface)拉取最新的代码

```
git clone https://github.com/Uniswap/uniswap-interface.git
```

拉取完成如下

```
➜  github git clone https://github.com/Uniswap/uniswap-interface.git
Cloning into 'uniswap-interface'...
remote: Enumerating objects: 10317, done.
remote: Total 10317 (delta 0), reused 0 (delta 0), pack-reused 10317
Receiving objects: 100% (10317/10317), 16.39 MiB | 5.88 MiB/s, done.
Resolving deltas: 100% (6171/6171), done.
```

之后进入到Uniswap目录

```
cd uniswap-interface
```

安装依赖

```
yarn
```

> 注意：这步如果提示你 `command not found: yarn` ，就需要先安装 `yarn`，通过命令
>
> ```brew install yarn
> brew install yarn
> ```

启动应用

```
yarn start
```

启动成功之后在浏览器窗口通过 `http://localhost:3000` 能成功访问Uniswap。

之后我们通过 `yarn build` 命令打包应用

```
➜  uniswap-interface git:(master) yarn build
yarn run v1.22.10
$ react-scripts build
Creating an optimized production build...
Compiled successfully.

File sizes after gzip:

  626.67 KB  build/static/js/4.27376761.chunk.js
  245.71 KB  build/static/js/5.44975b0b.chunk.js
  185.08 KB  build/static/js/9.c6fffc81.chunk.js
  125.35 KB  build/static/js/main.d38f6656.chunk.js
  70.25 KB   build/static/js/6.247f4f12.chunk.js
  62.43 KB   build/static/js/0.454e5a78.chunk.js
  6.56 KB    build/static/js/1.ab9e1769.chunk.js
  1.24 KB    build/static/js/runtime-main.d9a528e1.js
  913 B      build/static/css/4.f04942fe.chunk.css
  166 B      build/static/js/7.be8c5419.chunk.js
  165 B      build/static/js/8.9b1dfb7e.chunk.js

The project was built assuming it is hosted at ./.
You can control this with the homepage field in your package.json.

The build folder is ready to be deployed.

Find out more about deployment here:

  bit.ly/CRA-deploy

✨  Done in 74.15s.
```

成功打包之后的文件会放在 `./build` 目录下。

**制作Docker镜像**

现在我们就需要用刚刚打包的应用制作Docker镜像，制作的方式网上很多，可以参考[文章](https://juejin.cn/post/6844903815729119245)

>Docker 构建镜像有两种方式，一种方式是使用 `docker commit` 命令，另外一种方式使用 `docker build` 命令和 `Dockerfile` 文件。其中，不推荐使用 `docker commit` 命令进行构建，因为它没有使得整个流程标准化，因此，在企业的中更加推荐使用 `docker build` 命令和 `Dockerfile` 文件来构建我们的镜像。我们使用`Dockerfile` 文件可以让构建镜像更具备可重复性，同时保证启动脚本和运行程序的标准化。

这里我们采用 `docker build` 命令和 `Dockerfile` 文件的方式构建我们的镜像

首先我们创建 `Dockerfile` 文件通过命令 

```
vi Dockerfile
```

在里面填入内容

```
# 将nginx作为基础镜像
FROM nginx 
# 由于Uniswap是一个标准的web应用，我们将build目录复制到nginx目录中
COPY build /usr/share/nginx/html
# 标记内部运行的是80端口
EXPOSE 80
# 标识容器启动时执行的命令
CMD ["nginx", "-g", "daemon off;"]
```

保存好之后，执行Docker命令打包镜像 `docker build . -t uniswap:latest`

```
➜  uniswap-interface git:(master) ✗ docker build . -t uniswap:latest
[+] Building 18.1s (7/7) FINISHED
 => [internal] load .dockerignore                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                          0.0s
 => [internal] load build definition from Dockerfile                                                                                                                                                                     0.0s
 => => transferring dockerfile: 131B                                                                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                                                                                                                                          6.5s
 => [internal] load build context                                                                                                                                                                                        0.4s
 => => transferring context: 27.16MB                                                                                                                                                                                     0.4s
 => [1/2] FROM docker.io/library/nginx@sha256:6b1daa9462046581ac15be20277a7c75476283f969cb3a61c8725ec38d3b01c3                                                                                                          11.3s
 => => resolve docker.io/library/nginx@sha256:6b1daa9462046581ac15be20277a7c75476283f969cb3a61c8725ec38d3b01c3                                                                                                           0.0s
 => => sha256:6b1daa9462046581ac15be20277a7c75476283f969cb3a61c8725ec38d3b01c3 1.86kB / 1.86kB                                                                                                                           0.0s
 => => sha256:99d0a53e3718cef59443558607d1e100b325d6a2b678cd2a48b05e5e22ffeb49 1.36kB / 1.36kB                                                                                                                           0.0s
 => => sha256:bc9a0695f5712dcaaa09a5adc415a3936ccba13fc2587dfd76b1b8aeea3f221c 7.48kB / 7.48kB                                                                                                                           0.0s
 => => sha256:852e50cd189dfeb54d97680d9fa6bed21a6d7d18cfb56d6abfe2de9d7f173795 27.11MB / 27.11MB                                                                                                                         6.1s
 => => sha256:571d7e8523079365a306fa2fefb9bea2b500135098c32c829cd6bd738e2838a5 26.49MB / 26.49MB                                                                                                                         5.6s
 => => sha256:addb10abd9cb2f0b7497496559d847a5c53c73d891d0825a4d75cca7f246944e 600B / 600B                                                                                                                               1.3s
 => => sha256:d20aa7ccdb7773f8f448eef3f7a79a3181efa5dad07a899e9313835038a68dc9 901B / 901B                                                                                                                               2.0s
 => => sha256:8b03f1e11359b03ca2aba5f3436526fd523dc4dfa0f1b5c10a9257a9cb9f37cc 665B / 665B                                                                                                                               2.5s
 => => extracting sha256:852e50cd189dfeb54d97680d9fa6bed21a6d7d18cfb56d6abfe2de9d7f173795                                                                                                                                1.2s
 => => extracting sha256:571d7e8523079365a306fa2fefb9bea2b500135098c32c829cd6bd738e2838a5                                                                                                                                0.8s
 => => extracting sha256:addb10abd9cb2f0b7497496559d847a5c53c73d891d0825a4d75cca7f246944e                                                                                                                                0.0s
 => => extracting sha256:d20aa7ccdb7773f8f448eef3f7a79a3181efa5dad07a899e9313835038a68dc9                                                                                                                                0.0s
 => => extracting sha256:8b03f1e11359b03ca2aba5f3436526fd523dc4dfa0f1b5c10a9257a9cb9f37cc                                                                                                                                0.0s
 => [2/2] COPY build /usr/share/nginx/html                                                                                                                                                                               0.1s
 => exporting to image                                                                                                                                                                                                   0.2s
 => => exporting layers                                                                                                                                                                                                  0.1s
 => => writing image sha256:212b9bbf99e56be2d713732975816bab02bdfa0a0ac88a3d6826d2002e59ddd7                                                                                                                             0.0s
 => => naming to docker.io/library/uniswap:latest
```

之后查看刚刚打包完成的镜像

```
➜  uniswap-interface git:(master) ✗ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
uniswap             latest              212b9bbf99e5        About a minute ago   160MB
```

通过命令 `docker run -d --name uniswap -p 3256:80 --restart=unless-stopped uniswap:latest` 启动Uniswap

```
➜  uniswap-interface git:(master) ✗ docker run -d --name uniswap -p 3256:80 --restart=unless-stopped uniswap:latest
872e73e2b013cd56595271f7b65d180c0357a9f04791fdf59458a65b6455487b
➜  uniswap-interface git:(master) ✗ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
872e73e2b013        uniswap:latest      "/docker-entrypoint.…"   6 seconds ago       Up 5 seconds        0.0.0.0:3256->80/tcp   uniswap
```

之后通过浏览器访问刚刚部署的应用  `http://localhost:3255`  

**将镜像推送到远程仓库**

* 远程仓库：Docker Hub

镜像构建完毕之后，我们可以将它上传到 Docker Hub 上面。首先，我们需要通过 `docker login` 保证我们已经登录了。紧接着，

我们执行下面的命令

```
docker tag uniswap:latest 'your docker id'/uniswap:latest
```

之后使用 `docker push` 命令进行推送。

```
docker push 'your docker id'/uniswap:latest
```

输出结果如下

```
➜  uniswap-interface git:(master) ✗ docker push 'your docker id'/uniswap:latest
The push refers to repository [docker.io/'your docker id'/uniswap]
cf1918ee5ee0: Pushed
7e914612e366: Pushed
f790aed835ee: Pushed
850c2400ea4d: Pushed
7ccabd267c9f: Pushed
f5600c6330da: Pushed
latest: digest: sha256:0ed0d60c5a5267a9a0df7dd666e3b6ab7a25c66629e7bae66af9c547165493f6 size: 1574
```

然后我们就可以在Docker Hub上查看刚刚我们传上去的镜像。

**Akash部署Uniswap**

Akash官方的[部署教程](https://docs.akash.network/v/master/guides/deploy)上部署的应用是一个web应用，这里我们使用它来修改

这里是[deploy.yml](https://github.com/ovrclk/docs/blob/488f808b804b646771baf28e64dcfae2c5b09cac/guides/deploy/deploy.yml)的文件内容

```
➜  uniswap-interface git:(master) ✗ cat deploy.yml
---
version: "2.0"

services:
  web:
    image: ovrclk/lunie-light
    expose:
      - port: 3000
        as: 80
        to:
          - global: true

profiles:
  compute:
    web:
      resources:
        cpu:
          units: 0.1
        memory:
          size: 512Mi
        storage:
          size: 512Mi
  placement:
    westcoast:
      attributes:
        organization: ovrclk.com
      signedBy:
        anyOf:
          - "akash1vz375dkt0c60annyp6mkzeejfq0qpyevhseu05"
      pricing:
        web:
          denom: uakt
          amount: 1000

deployment:
  web:
    westcoast:
      profile: web
      count: 1
```

我们只需要将 `image: ovrclk/lunie-light` 修改为刚刚上传的 `'your docker id'/uniswap:latest`

剩下的就是按照官方教程部署了，查看我们账户是否有足够的akt来支付这次部署的费用

```
root@yaakov:~# akash query bank balances --node $AKASH_NODE $ACCOUNT_ADDRESS
balances:
- amount: "60396497"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```

> 这里需要注意一下  `akt`  的精度是6，也就是我们获取的金额是 `60.396497akt` = `60396497 uakt`

```
root@yaakov:~# akash tx deployment create ./deploy.yml --from $KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID 
Enter keyring passphrase:
{"height":"136690","txhash":"B2440B4C40C45447BA8C269311ED6691325CB917EB3A76D3A6BF6D09FAE4BB91","codespace":"","code":0,"data":"0A130A116372656174652D6465706C6F796D656E74","raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-created\"},{\"key\":\"version\",\"value\":\"be4097563ba05651ef5e3d44a25d30dd9144b75bf9942e7d8c27d58945b5d87f\"},{\"key\":\"owner\",\"value\":\"akash1rrw2hsj9l0zsulc6c8sgg53783mz6a7yvwy4qs\"},{\"key\":\"dseq\",\"value\":\"136688\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-deployment\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"akash.v1","attributes":[{"key":"module","value":"deployment"},{"key":"action","value":"deployment-created"},{"key":"version","value":"be4097563ba05651ef5e3d44a25d30dd9144b75bf9942e7d8c27d58945b5d87f"},{"key":"owner","value":"akash1rrw2hsj9l0zsulc6c8sgg53783mz6a7yvwy4qs"},{"key":"dseq","value":"136688"}]},{"type":"message","attributes":[{"key":"action","value":"create-deployment"}]}]}],"info":"","gas_wanted":"200000","gas_used":"56891","tx":null,"timestamp":""}
```

检查租赁的状态

```
root@yaakov:~# akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE --state active
leases:
- lease_id:
    dseq: "136731"
    gseq: 1
    oseq: 1
    owner: akash1rrw2hsj9l0zsulc6c8sgg53783mz6a7yvwy4qs
    provider: akash1y8xhp9ekxctahvex7842h607lmwp50q0n89tw0
  price:
    amount: "87"
    denom: uakt
  state: active
pagination:
  next_key: null
  total: "0"
```

这里我们花费了 `0.000087 akt` 来完成了本次操作，我们先保存几个变量方便我们后面使用

```
export PROVIDER=akash1y8xhp9ekxctahvex7842h607lmwp50q0n89tw0
export DSEQ=136731
export OSEQ=1
export GSEQ=1
```

上传 `Manifest`

```
akash provider send-manifest deploy.yml --node $AKASH_NODE --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ --owner $ACCOUNT_ADDRESS --provider $PROVIDER
```

上传完成之后可以通过下面命令查看详情

```
akash provider lease-status --node $AKASH_NODE --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ --provider $PROVIDER --owner $ACCOUNT_ADDRESS
```

得到如下输出

```
{
  "services": {
    "web": {
      "name": "web",
      "available": 1,
      "total": 1,
      "uris": [
        "5taisrhjm9dpv2dugajt94p9jc.provider1.akashdev.net"
      ],
      "observed-generation": 0,
      "replicas": 0,
      "updated-replicas": 0,
      "ready-replicas": 0,
      "available-replicas": 0
    }
  },
  "forwarded-ports": {}
}
```

现在就可以通过浏览器访问我们部署的应用了 [5taisrhjm9dpv2dugajt94p9jc.provider1.akashdev.net](5taisrhjm9dpv2dugajt94p9jc.provider1.akashdev.net)

> 这里我部署了两次才成功，第一次出现502

至此部署全部结束。

