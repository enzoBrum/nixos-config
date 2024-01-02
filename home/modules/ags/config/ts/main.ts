import { Variable } from 'resource:///com/github/Aylur/ags/variable.js';
import { Widget } from 'resource:///com/github/Aylur/ags/widget.js';
import { Workspaces, focusedTitle } from './workspaces.js';

const time = new Variable('', {
    poll: [1000, 'date'],
});

const left_bar = (monitor: number, two_monitors: boolean) => Widget.Box({
    children: [
        Workspaces(two_monitors ? 1 - monitor : monitor),
        focusedTitle()
    ]
})

const Bar = (monitor: number, two_monitors: boolean = true) => Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: left_bar(monitor, two_monitors),
        end_widget: Widget.Label({
            hpack: 'center',
            binds: [['label', time]],
        }),
    })
})

export default {
    windows: [Bar(0), Bar(1)]
}
