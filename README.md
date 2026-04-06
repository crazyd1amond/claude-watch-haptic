# Apple Watch Haptic for Claude Code ⌚️

[English](#english) | [中文](#中文)

---

<a id="english"></a>
## English

A lightweight hook system that triggers Apple Watch haptic feedback when Claude Code stops running (task complete, permission prompt, or any loop pause).

**No iPhone apps, no persistent trace, low latency (~8s), vibration only.**

### How It Works

1. **Claude Code** fires `Stop` or `Notification` hook
2. **Shell script** creates an iCloud Reminder with a due date 8 seconds in the future
3. **iCloud** pushes the reminder to iPhone (~2–5s sync)
4. **iPhone** notifies → **Apple Watch** mirrors notification and vibrates
5. **Auto‑cleanup** deletes the reminder after 15 seconds (no trace)

### Setup

#### 1. Script & Hook
```bash
# Clone this repo
git clone https://github.com/crazyd1amond/claude-watch-haptic.git
cd claude-watch-haptic

# Make script executable
chmod +x buzz.sh

# Symlink (optional, fixes path spaces)
mkdir -p ~/ccremind
ln -sf "$(pwd)/buzz.sh" ~/ccremind/buzz.sh
```

#### 2. Claude Code Configuration
Edit `~/.claude/settings.json` and add:
```json
"hooks": {
  "Stop": [
    {
      "matcher": "",
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/buzz.sh"
        }
      ]
    }
  ],
  "Notification": [
    {
      "matcher": "",
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/buzz.sh"
        }
      ]
    }
  ]
}
```
Replace `/path/to/buzz.sh` with the actual path (e.g., `~/ccremind/buzz.sh`).

#### 3. iPhone & Watch (one‑time)
- **iPhone** → Settings → Notifications → Reminders → Allow Notifications: ON, Sounds: OFF
- **Watch app** → Notifications → Reminders → Mirror my iPhone: ON
- **iCloud sync** → Settings → Apple ID → iCloud → Reminders: ON (both Mac and iPhone)

### Test
```bash
./buzz.sh
```
Wait ~8 seconds → Watch vibrates → reminder auto‑deletes after 15s.

### Files
- `buzz.sh` – Core AppleScript that creates/deletes the iCloud reminder
- `README.md` – This documentation
- `.gitignore` – Ignores macOS temporary files

### Publishing to GitHub

This repository is already initialized as a Git repository. To publish it to GitHub:

1. **Create a new repository** on [GitHub](https://github.com/new)
   - Repository name: e.g., `claude-watch-haptic`
   - Keep it public or private as you prefer
   - **Do not** initialize with README, .gitignore, or license (we already have them)

2. **Add the remote and push**
   ```bash
   git remote add origin https://github.com/crazyd1amond/claude-watch-haptic.git
   git branch -M main
   git push -u origin main
   ```

3. **The clone URL has been updated** to match your GitHub URL.

### Why 8 Seconds?
iCloud sync takes 2–5 seconds. If the reminder’s due time is “now”, it arrives overdue and iOS skips the notification. Setting it 8 seconds ahead ensures the notification fires after sync.

### License
MIT – free to use, modify, distribute.

---

<a id="中文"></a>
## 中文

Claude Code 任务完成时触发 Apple Watch 震动的轻量钩子系统（任务结束、权限请求、循环暂停时均触发）。

**无需 iPhone 第三方 App，无持久痕迹，低延迟（约 8 秒），仅震动。**

### 工作原理

1. **Claude Code** 触发 `Stop` 或 `Notification` 钩子
2. **Shell 脚本** 创建一个 8 秒后到期的 iCloud 提醒事项
3. **iCloud** 将提醒推送到 iPhone（约 2–5 秒同步）
4. **iPhone** 通知 → **Apple Watch** 镜像通知并震动
5. **自动清理** 15 秒后删除提醒事项（无痕迹）

### 安装配置

#### 1. 脚本与钩子
```bash
# 克隆本仓库
git clone https://github.com/crazyd1amond/claude-watch-haptic.git
cd claude-watch-haptic

# 赋予执行权限
chmod +x buzz.sh

# 符号链接（可选，修复路径空格问题）
mkdir -p ~/ccremind
ln -sf "$(pwd)/buzz.sh" ~/ccremind/buzz.sh
```

#### 2. Claude Code 配置
编辑 `~/.claude/settings.json`，添加：
```json
"hooks": {
  "Stop": [
    {
      "matcher": "",
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/buzz.sh"
        }
      ]
    }
  ],
  "Notification": [
    {
      "matcher": "",
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/buzz.sh"
        }
      ]
    }
  ]
}
```
将 `/path/to/buzz.sh` 替换为实际路径（例如 `~/ccremind/buzz.sh`）。

#### 3. iPhone 与 Watch（一次性设置）
- **iPhone** → 设置 → 通知 → 提醒事项 → 允许通知：开，声音：关
- **Watch app** → 通知 → 提醒事项 → 镜像我的 iPhone：开
- **iCloud 同步** → 设置 → Apple ID → iCloud → 提醒事项：开（Mac 和 iPhone 均需开启）

### 测试
```bash
./buzz.sh
```
等待约 8 秒 → Watch 震动 → 提醒事项在 15 秒后自动删除。

### 文件说明
- `buzz.sh` – 核心 AppleScript，创建/删除 iCloud 提醒
- `README.md` – 本文档
- `.gitignore` – 忽略 macOS 临时文件


### 为什么是 8 秒？
iCloud 同步需要 2–5 秒。如果提醒的到期时间设为“现在”，等提醒到达 iPhone 时已过期，iOS 会静默跳过通知。设为 8 秒后到期可确保同步完成后才触发通知。

### 许可证
MIT – 可自由使用、修改、分发。
