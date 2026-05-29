# test_sim.py — make sure the daemon is running in another terminal
from reachy_mini import ReachyMini
from reachy_mini.utils import create_head_pose

with ReachyMini() as mini:                      # auto-detects the daemon
    mini.wake_up()                              # torque on, lift to neutral
    for _ in range(2):
        mini.goto_target(head=create_head_pose(pitch= 18, degrees=True), duration=0.5)
        mini.goto_target(head=create_head_pose(pitch=-18, degrees=True), duration=0.5)
    mini.goto_target(head=create_head_pose(), duration=0.5)   # back to neutral
    print("✅ smoke test passed")
