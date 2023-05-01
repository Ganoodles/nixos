import argparse
import subprocess

# Create the argument parser
parser = argparse.ArgumentParser(description='Change system volume by a percentage.')
parser.add_argument('--percent', type=int, help='Percentage to change the volume by')
parser.add_argument('--change', choices=['up', 'down'], help='Direction to change the volume')

# Parse the arguments from the command line
args = parser.parse_args()

# Calculate the volume change
if args.change == 'up':
    volume_change = '{}%+'.format(args.percent)
elif args.change == 'down':
    volume_change = '{}%-'.format(args.percent)

# Set the new volume level
subprocess.call(['wpctl', 'set-volume', '-l', '1.5', '@DEFAULT_AUDIO_SINK@', volume_change])
