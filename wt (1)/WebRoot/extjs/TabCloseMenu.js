
/*
 * Ext JS Library 2.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */


// Very simple plugin for adding a close context menu to tabs
Ext.ux.TabCloseMenu = function () {
	var tabs, menu, ctxItem;
	this.init = function (tp) {
		tabs = tp;
		tabs.on("contextmenu", onContextMenu);
	};
	function onContextMenu(ts, item, e) {
		if (!menu) { // create context menu on first right click
			menu = new Ext.menu.Menu([{id:tabs.id + "-close", text:"\xe5\x85\xb3\xe9\x97\xe5\xbd\x93\xe5\x89\x8d\xe9\x80\x89\xe9\xa1\xb9\xe5\x8d\xa1", iconCls:"houfei-closeCurrentTab", handler:function () {
				tabs.remove(ctxItem);
			}}, {id:tabs.id + "-close-others", text:"\xe9\x99\xa4\xe6\xa4\xe4\xb9\x8b\xe5\xa4\x96\xe9\x83\xbd\xe5\x85\xb3\xe9\x97", iconCls:"houfei-closeOtherTab", handler:function () {
				tabs.items.each(function (item) {
					if (item.closable && item != ctxItem) {
						tabs.remove(item);
					}
				});
			}}]);
		}
		ctxItem = item;
		var items = menu.items;
		items.get(tabs.id + "-close").setDisabled(!item.closable);
		var disableOthers = true;
		tabs.items.each(function () {
			if (this != item && this.closable) {
				disableOthers = false;
				return false;
			}
		});
		items.get(tabs.id + "-close-others").setDisabled(disableOthers);
		menu.showAt(e.getPoint());
	}
};

