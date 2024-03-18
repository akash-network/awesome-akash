# Download the grok-1 weights, move them to `checkpoints/ckpt-0` directory
mkdir -p checkpoints/
aria2c -d weights --summary-interval 5 --check-certificate=false --max-tries=99 --retry-wait=5 --always-resume=true --max-file-not-found=99 --conditional-get=true -s 8 -x 8 -k 1M -j 1 'magnet:?xt=urn:btih:5f96d43576e3d386c9ba65b883210a393b68210e&tr=https%3A%2F%2Facademictorrents.com%2Fannounce.php&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce'
mv weights/grok-1/ckpt-0/ checkpoints/
rm -r weights/

# Clone the grok-1 repository, install reqs, and run the model
git clone https://github.com/xai-org/grok-1 .
pip install -r requirements.txt
python run.py