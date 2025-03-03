# chat-app-grpc

Shared gRPC service definitions for the chat application.

## Setup as a Git Submodule

1. Add to your backend/frontend project:

```bash
git submodule add https://github.com/yourusername/chat-app-grpc.git backend/proto
```

2. Initialize and update submodules:

```bash
git submodule init
git submodule update
```

3. Add the submodule to your `.gitignore`:

```bash
echo "backend/proto" >> .gitignore
```

4. Install dependencies:

```bash
cd backend/proto
npm install
```
