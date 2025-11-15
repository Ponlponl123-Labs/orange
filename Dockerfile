# Use Bun's official image
FROM oven/bun:1 AS base
WORKDIR /app

# Install dependencies
FROM base AS deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Build the application to a binary
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN bun build src/index.ts --compile --outfile=orange

# Production image - use a minimal base
FROM debian:bookworm-slim AS runner
WORKDIR /app

ENV NODE_ENV=production

# Copy only the binary
COPY --from=builder /app/orange ./orange

# Run the bot
CMD ["./orange"]
