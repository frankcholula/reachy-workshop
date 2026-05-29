VENV := reachy_mini_env
PYTHON := $(VENV)/bin/python
MJPYTHON := $(VENV)/bin/mjpython
DYLD_FIX := DYLD_LIBRARY_PATH="$(HOME)/.local/share/uv/python/cpython-3.12.9-macos-aarch64-none/lib:$$DYLD_LIBRARY_PATH"

reachy-sim:
	@echo "Launching the Reachy simulator..."
	$(DYLD_FIX) $(MJPYTHON) -m reachy_mini.daemon.app.main --sim

hello:
	@echo "Running hello script..."
	$(PYTHON) scripts/hello.py

say-hello:
	@echo "Running say hello script..."
	$(PYTHON) scripts/say_hello.py

workout-buddy:
	@echo "Running workout buddy..."
	$(PYTHON) workout_buddy/main.py

smoke-test:
	@echo "Running smoke test (daemon must be running)..."
	$(PYTHON) scripts/smoke_test.py

brev:
	@echo "Connecting to reachy-workshop (A100) on Brev..."
	brev shell reachy-workshop

.PHONY: reachy-sim hello say-hello workout-buddy smoke-test brev
