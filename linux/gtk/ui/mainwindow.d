module ui.mainwindow;

import gio.Menu;

import gtk.Box;
import gtk.ComboBox;
import gtk.Entry;
import gtk.Label;
import gtk.MenuButton;

import adw.Clamp;
import adw.HeaderBar;
import adw.StatusPage;
import adw.Window;

import constants;
import ui.devicewidget;

class MainWindow: Window {
    DeviceWidget[string] deviceWidgets;
    private Box devicesBox;

    Label connectDeviceLabel;

    this() {
        // setTitle(applicationName);
        setTitle("");
        setDefaultSize(600, 400);

        Box mainWindowBox = new Box(Orientation.VERTICAL, 4); {
            HeaderBar headerBar = new HeaderBar();
            headerBar.addCssClass("flat"); {
                auto hamburgerButton = new MenuButton();
                hamburgerButton.setProperty("direction", ArrowType.NONE);

                Menu menu = new Menu();
                Menu optionsMenu = new Menu();
                optionsMenu.append("Settings", "app.settings");
                menu.appendSection(null, optionsMenu);
                Menu appActions = new Menu();
                appActions.append("About " ~ applicationName, "app.about");
                menu.appendSection(null, appActions);

                hamburgerButton.setMenuModel(menu);

                headerBar.packEnd(hamburgerButton);
            }
            mainWindowBox.append(headerBar);

            StatusPage content = new StatusPage();
            content.setTitle(applicationName); {
                Clamp clamp = new Clamp(); {
                    devicesBox = new Box(Orientation.VERTICAL, 0); {
                        connectDeviceLabel = new Label("Please connect a device.");
                        devicesBox.append(connectDeviceLabel);
                    }
                    clamp.setChild(devicesBox);
                }
                content.setChild(clamp);
            }
            mainWindowBox.append(content);
        }
        setChild(mainWindowBox);
    }

    void addDeviceWidget(string deviceId, string udid) {
        if (deviceId !in deviceWidgets) {
            connectDeviceLabel.hide();
            auto deviceWidget = new DeviceWidget(deviceId, udid);
            deviceWidgets[deviceId] = deviceWidget;
            devicesBox.append(deviceWidget);
        }
    }

    void removeDeviceWidget(string deviceId) {
        if (deviceId in deviceWidgets) {
            deviceWidgets[deviceId].unparent();
            deviceWidgets.remove(deviceId);
            if (deviceWidgets.length == 0) {
                connectDeviceLabel.show();
            }
        }
    }
}