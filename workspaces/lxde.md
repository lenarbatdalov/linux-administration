# .config/openbox/lxqt-rc.xml
```xml
    <!-- Window snapping code we are adding -->
    <keybind key="Super-Left">
    <action name="UnmaximizeFull"/>
    <action name="MoveResizeTo">
        <width>50%</width>
        <height>100%</height>
        <x>0%</x>
        <y>0%</y>
    </action>
    </keybind>
    <keybind key="Super-Right">
    <action name="UnmaximizeFull"/>
    <action name="MoveResizeTo">
        <width>50%</width>
        <height>100%</height>
        <x>50%</x>
        <y>0%</y>
    </action>
    </keybind>
    <keybind key="Super-Down">
    <action name="UnmaximizeFull"/>
    <action name="MoveResizeTo">
        <width>100%</width>
        <height>50%</height>
        <x>0%</x>
        <y>50%</y>
    </action>
    </keybind>
    <keybind key="Super-Up">
    <action name="UnmaximizeFull"/>
    <action name="MoveResizeTo">
        <width>100%</width>
        <height>50%</height>
        <x>0%</x>
        <y>0%</y>
    </action>
    </keybind>
```

openbox --reconfigure
