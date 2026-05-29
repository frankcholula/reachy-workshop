import tempfile
import time
import numpy as np
from scipy.spatial.transform import Rotation as R
from gtts import gTTS
from reachy_mini import ReachyMini

TEXT = "I like big butts and can not lie."

with tempfile.NamedTemporaryFile(suffix=".mp3", delete=False) as f:
    speech_file = f.name

gTTS(text=TEXT, lang="en").save(speech_file)


def head_pose(roll=0, pitch=0, yaw=0):
    pose = np.eye(4)
    pose[:3, :3] = R.from_euler("xyz", [roll, pitch, yaw], degrees=True).as_matrix()
    return pose


with ReachyMini() as mini:
    mini.media.play_sound(speech_file)

    # Head bops to the beat
    for _ in range(3):
        mini.goto_target(head=head_pose(pitch=15), antennas=[0.5, -0.5], body_yaw=0.0, duration=0.25)
        mini.goto_target(head=head_pose(pitch=-8), antennas=[-0.5, 0.5], body_yaw=0.0, duration=0.25)

    # Body sway side to side
    for _ in range(2):
        mini.goto_target(head=head_pose(roll=15), body_yaw=0.4, duration=0.3)
        mini.goto_target(head=head_pose(roll=-15), body_yaw=-0.4, duration=0.3)

    # Antennas pump up + body spin
    mini.goto_target(antennas=[1.2, 1.2], body_yaw=1.2, duration=0.4)
    mini.goto_target(antennas=[1.2, 1.2], body_yaw=-1.2, duration=0.4)

    # Head shake ("can not lie!")
    for _ in range(3):
        mini.goto_target(head=head_pose(yaw=30), body_yaw=0.0, duration=0.15)
        mini.goto_target(head=head_pose(yaw=-30), body_yaw=0.0, duration=0.15)

    # Return to neutral
    mini.goto_target(head=np.eye(4), antennas=[0.0, 0.0], body_yaw=0.0, duration=0.6)
    time.sleep(0.5)
