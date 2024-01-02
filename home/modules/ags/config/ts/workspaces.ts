import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

export const focusedTitle = () => Widget.Label({
    label: Hyprland.active.client.bind('title'),
    visible: Hyprland.active.client.bind('address')
        .transform(addr => !!addr),
});

const dispatch = ws => Hyprland.sendMessage(`dispatch workspace ${ws}`);

export const Workspaces = (monitor: number) => Widget.EventBox({
    on_scroll_up: () => dispatch('+1'),
    on_scroll_down: () => dispatch('-1'),
    child: Widget.Box({
        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
            attribute: i,
            child: Widget.Label(`${monitor*10 + i}`),
            on_clicked: () => dispatch(monitor*10 + i),
        })),
    }),
});