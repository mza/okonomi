.PHONY: help start-infra start-platform start-all stop-infra stop-platform stop-all restart-all status logs-infra logs-platform logs-all clean

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Paths
INFRA_DIR := ../infra
PLATFORM_DIR := ../platform

help:
	@echo "$(BLUE)═══════════════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)                    System Management                          $(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(GREEN)Infrastructure Layer:$(NC)"
	@echo "  make start-infra     - Start Ollama"
	@echo "  make stop-infra      - Stop Ollama"
	@echo "  make logs-infra      - View Ollama logs"
	@echo ""
	@echo "$(GREEN)Platform Layer:$(NC)"
	@echo "  make start-platform  - Start LiteLLM (requires infra)"
	@echo "  make stop-platform   - Stop LiteLLM"
	@echo "  make logs-platform   - View LiteLLM logs"
	@echo ""
	@echo "$(GREEN)All Services:$(NC)"
	@echo "  make start-all       - Start all services"
	@echo "  make stop-all        - Stop all services"
	@echo "  make restart-all     - Restart all services"
	@echo "  make status          - Show service status"
	@echo "  make logs-all        - View all logs"
	@echo ""
	@echo "$(GREEN)Maintenance:$(NC)"
	@echo "  make clean           - Remove all containers and volumes"
	@echo ""

start-infra:
	@echo "$(BLUE)Starting Infrastructure Layer...$(NC)"
	@cd $(INFRA_DIR)/ollama && docker-compose up -d
	@echo "$(GREEN)✓ Ollama started$(NC)"
	@sleep 2
	@make status

start-platform: start-infra
	@echo "$(BLUE)Starting Platform Layer...$(NC)"
	@cd $(PLATFORM_DIR)/litellm && docker-compose up -d
	@echo "$(GREEN)✓ LiteLLM started$(NC)"
	@sleep 2
	@make status

start-all: start-platform
	@echo "$(GREEN)═══════════════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)All services started successfully!$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════════════════════════$(NC)"

stop-platform:
	@echo "$(YELLOW)Stopping Platform Layer...$(NC)"
	@cd $(PLATFORM_DIR)/litellm && docker-compose down
	@echo "$(GREEN)✓ LiteLLM stopped$(NC)"

stop-infra:
	@echo "$(YELLOW)Stopping Infrastructure Layer...$(NC)"
	@cd $(INFRA_DIR)/ollama && docker-compose down
	@echo "$(GREEN)✓ Ollama stopped$(NC)"

stop-all: stop-platform stop-infra
	@echo "$(GREEN)All services stopped$(NC)"

restart-all: stop-all start-all

status:
	@echo "$(BLUE)═══════════════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)                    Service Status                             $(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)Infrastructure Layer:$(NC)"
	@docker ps --filter "name=ollama" --format "  {{.Names}}\t{{.Status}}\t{{.Ports}}" || echo "  No containers running"
	@echo ""
	@echo "$(YELLOW)Platform Layer:$(NC)"
	@docker ps --filter "name=litellm" --format "  {{.Names}}\t{{.Status}}\t{{.Ports}}" || echo "  No containers running"
	@echo ""

logs-infra:
	@cd $(INFRA_DIR)/ollama && docker-compose logs -f

logs-platform:
	@cd $(PLATFORM_DIR)/litellm && docker-compose logs -f

logs-all:
	@docker logs -f ollama &
	@docker logs -f litellm

clean:
	@echo "$(RED)WARNING: This will remove all containers and volumes!$(NC)"
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		cd $(PLATFORM_DIR)/litellm && docker-compose down -v; \
		cd $(INFRA_DIR)/ollama && docker-compose down -v; \
		echo "$(GREEN)Cleanup complete$(NC)"; \
	else \
		echo "$(YELLOW)Cancelled$(NC)"; \
	fi
