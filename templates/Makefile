CHECK=✔ Done

clean-class:
	@sudo printf "Cleaning class index..."
	@rm cache/class_index.php
	@touch cache/class_index.php
	@chmod 666 cache/class_index.php
	@echo "                   ${CHECK}"

clean-cache:
	@printf "Cleaning cache..."
	-@rm themes/<%= theme %>/cache/*.css themes/<%= theme %>/cache/*.js 2>/dev/null || true
	@echo "                   ${CHECK}"
