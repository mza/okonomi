#!/usr/bin/env bash
# migrations/030-ruby-rails-docker.sh
# Installs Ruby, Rails, and Docker

set -euo pipefail

OKONOMI_ROOT="${OKONOMI_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$OKONOMI_ROOT/install/helpers/functions"

log_info "Installing Ruby, Rails, and Docker..."

# Install Ruby and related tools
log_info "Installing Ruby..."
sudo pacman -S --needed --noconfirm ruby ruby-docs ruby-bundler

# Install Rails via gem
log_info "Installing Rails..."
gem install rails --user-install

# Install Docker
log_info "Installing Docker..."
sudo pacman -S --needed --noconfirm docker docker-compose

# Enable and start Docker service
log_info "Enabling Docker service..."
sudo systemctl enable docker.service

# Add current user to docker group
log_info "Adding $USER to docker group..."
sudo usermod -aG docker "$USER"

log_success "Ruby, Rails, and Docker installed"
log_info "Ruby version: $(ruby --version)"
log_info "Rails version: $(rails --version 2>/dev/null || echo 'Rails installed, please re-login or run: source ~/.bashrc')"
log_info "Docker version: $(docker --version)"
log_warn "Please log out and log back in for docker group changes to take effect"
log_info "Run 'docker run hello-world' to verify Docker installation"
