import type { Plugin } from "@opencode-ai/plugin";
import { appendFile } from "node:fs/promises";

const sendOsc777 = async (title: string, body: string) => {
  try {
    await appendFile("/dev/tty", `\x1b]777;notify;${title};${body}\x1b\\\x07`);
  } catch {
    // No controlling TTY is available.
  }
};

export const MacOSNotifications: Plugin = async ({ client }) => {
  return {
    event: async ({ event }) => {
      // Session completion notification
      if (event.type === "session.idle") {
        // Show terminal toast
        await client.tui.showToast({
          body: {
            message: "Session completed!",
            variant: "success",
            title: "OpenCode",
          },
        });

        await sendOsc777("OpenCode", "Session completed!");
      }
    },

    "permission.ask": async (permissionInfo, output) => {
      // Show notification when approval is needed
      const actionType = permissionInfo.type || "unknown";

      // Show terminal toast
      await client.tui.showToast({
        body: {
          message: `Approval needed for: ${actionType}`,
          variant: "warning",
          title: "Permission Required",
        },
      });

      await sendOsc777("OpenCode - Permission Required", `Approval needed for: ${actionType}`);

      // Let OpenCode prompt the user (don't change the default behavior)
      output.status = "ask";
    },
  };
};
