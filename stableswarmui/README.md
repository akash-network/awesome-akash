# StableSwarmUI

**Deploy StableSwarmUI 0.6.4 Beta on Akash Network**.

Just deploy [deploy.yml](./deploy.yml) file on **Akash Network** and enjoy **StableSwarmUI**!

> If your need download private model huggingface - uncomment and set `MODEL_LINK` & `HF_TOKEN` variables.


![Example](example.gif)

A Modular **Stable Diffusion** Web-User-Interface, with an emphasis on making powertools easily accessible, high performance, and extensibility.

# Status

This project is in **Beta** status. This means for most tasks, Swarm has excellent tooling available to you, but there is much more planned. Swarm is recommended as an ideal UI for most users, beginners and pros alike. There are still some things to be worked out.

Beginner users will love Swarm's primary Generate tab interface, making it easy to generate anything with a variety of powerful features. Advanced users may favor the Comfy Workflow tab to get the unrestricted raw graph, but will still have reason to come back to the Generate tab for convenience features (image editor, auto-workflow-generation, etc) and powertools (eg Grid Generator).

Those interested in helping push Swarm from Beta to a Full ready-for-anything perfected Release status are welcome to submit PRs (read the [Contributing](/CONTRIBUTING.md) document first), and you can contact us here on GitHub or on [Discord](https://discord.gg/q2y38cqjNw). I highly recommended reaching out to ask about plans for a feature before PRing it. There may already be specific plans or even a work in progress.

Key feature targets not yet implemented:
- Better mobile browser support
- full detail "Current Model" display in UI, separate from the model selector (probably as a tab within the batch sidebar?)
    - And a way to dynamically shift tabs around between spots for convenience / layout customization
- LLM-assisted prompting
- convenient direct-distribution of Swarm as a program (Electron app?)

# Documentation

See [the documentation folder](/docs/README.md).

# Motivations

The "Swarm" name is in reference to the original key function of the UI: enabling a 'swarm' of GPUs to all generate images for the same user at once (especially for large grid generations). This is just the feature that inspired the name and not the end all of what Swarm is.

The overall goal of StableSwarmUI is to a be full-featured one-stop-shop for all things Stable Diffusion.

See [the motivations document](/docs/Motivations.md) for motivations on technical choices.

# Legal

- Original repository https://github.com/Stability-AI/StableSwarmUI

This project:
- has the ability to auto-install [ComfyUI](https://github.com/comfyanonymous/ComfyUI) (GPL).
- has the option to use as a backend [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) (AGPL).
- can automatically install [christophschuhmann/improved-aesthetic-predictor](https://github.com/christophschuhmann/improved-aesthetic-predictor) (Apache2).
- can automatically install [yuvalkirstain/PickScore](https://github.com/yuvalkirstain/PickScore) (MIT).
- can automatically install [git-for-windows](https://git-scm.com/download/win) (GPLv2).
- can automatically install MIT/BSD/Apache2/PythonSoftwareFoundation pip packages: [spandrel](https://pypi.org/project/spandrel/), [dill](https://pypi.org/project/dill/), [imageio-ffmpeg](https://pypi.org/project/imageio-ffmpeg/), [opencv-python-headless](https://pypi.org/project/opencv-python-headless/), [matplotlib](https://pypi.org/project/matplotlib/), [rembg](https://pypi.org/project/rembg/), [kornia](https://pypi.org/project/kornia/), [Cython](https://pypi.org/project/Cython/)
- can automatically install [ultralytics](https://github.com/ultralytics/ultralytics) (AGPL) for `YOLOv8` face detection (ie `SwarmYoloDetection` node or `<segment:yolo-...>` syntax usage may become subject to AGPL terms),
- can automatically install [insightface](https://github.com/deepinsight/insightface) (MIT) for `IP Adapter - Face` support
- uses [JSON.NET](https://github.com/JamesNK/Newtonsoft.Json) (MIT), [FreneticUtilities](https://github.com/FreneticLLC/FreneticUtilities) (MIT), [LiteDB](https://github.com/mbdavid/LiteDB) (MIT), [ImageSharp](https://github.com/SixLabors/ImageSharp/) (Apache2 under open-source Split License)
- embeds copies of web assets from [BootStrap](https://getbootstrap.com/) (MIT), [Select2](https://select2.org/) (MIT), [JQuery](https://jquery.com/) (MIT), [exifr](https://github.com/MikeKovarik/exifr) (MIT).
- has the option to connect to remote servers to use [the Stability AI API](https://platform.stability.ai/) as a backend.
- supports user-built extensions which may have their own licenses or legal conditions.

StableSwarmUI itself is under the MIT license, however some usages may be affected by the GPL variant licenses of connected projects list above, and note that any models used have their own licenses.

### License

The MIT License (MIT)

Copyright (c) 2024 Stability AI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
