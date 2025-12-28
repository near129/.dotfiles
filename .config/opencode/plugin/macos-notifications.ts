import type { Plugin } from "@opencode-ai/plugin";

export const MacOSNotifications: Plugin = async ({ client, $ }) => {
  return {
    event: async ({ event }) => {
      // Session completion notification
      if (event.type === "session.idle") {
        // Show terminal toast
        await client.tui.showToast({
          body: {
            message: "✅ Session completed!",
            variant: "success",
            title: "OpenCode",
          },
        });

        // Show macOS system notification
        await $`osascript -e 'display notification "Session completed!" with title "OpenCode" sound name "Glass"'`;
      }
    },

    "permission.ask": async (permissionInfo, output) => {
      // Show notification when approval is needed
      const actionTitle = permissionInfo.title || "Unknown action";

      // Show terminal toast
      await client.tui.showToast({
        body: {
          message: `! Approval needed for: ${actionTitle}`,
          variant: "warning",
          title: "Permission Required",
        },
      });

      // Show macOS system notification
      await $`osascript -e 'display notification "Approval needed for: ${actionTitle}" with title "OpenCode - Permission Required" sound name "Ping"'`;

      // Let OpenCode prompt the user (don't change the default behavior)
      output.status = "ask";
    },
  };
};
