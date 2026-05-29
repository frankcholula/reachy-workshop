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

# NOTE: LLM forwards to :8010 (not :8000) — the Reachy daemon owns :8000 locally.
brev-ports:
	@echo "Forwarding Brev ports (LLM→8010, TTS→8002)..."
	brev port-forward reachy-workshop --port 8010:8000 &
	brev port-forward reachy-workshop --port 8002:8002 &
	@echo "Port forwards running in background. Kill with: kill %1 %2"

.PHONY: reachy-sim hello say-hello workout-buddy smoke-test brev brev-ports
