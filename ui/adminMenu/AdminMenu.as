package adminMenu
{
    import d2enums.BuildTypeEnum;
    import adminMenu.items.BasicItem;
    import adminMenu.items.SendCommandItem;
    import flash.xml.XMLNode;
    import adminMenu.items.SeparatorItem;
    import adminMenu.items.SendChatItem;
    import adminMenu.items.PrepareCommanditem;
    import adminMenu.items.BatchItem;
    import adminMenu.items.MenuItem;
    import adminMenu.items.ReloadXmlItem;
    import d2data.Server;
    import flash.xml.XMLDocument;
    import d2enums.GameHierarchyEnum;

    public class AdminMenu 
    {

        private static const ADMIN_CONFIG_URL_RELEASE:String = "http://menuadmin.dofus.com/dofus2/";
        private static const ADMIN_CONFIG_URL_BETA:String = "http://menuadmin.dofus.com/dofus2-beta/";
        private static const ADMIN_CONFIG_URL_INTERNAL:String = "http://deposit.dofus2.lan/admin/";

        private var _menu:Array;
        private var _startCmd:Array;
        private var _rank:int = 0;
        private var _hierarchyString:String = null;
        private var _rights:Array;
        private var _menuAdminUrls:Array;

        public function AdminMenu()
        {
            this._menu = [];
            this._startCmd = [];
            this._menuAdminUrls = [];
            super();
            if (Api.systemApi.getBuildType() >= BuildTypeEnum.INTERNAL)
            {
                Api.fileApi.trustedLoadXmlFile((ADMIN_CONFIG_URL_INTERNAL + "ranks.xml"), this.onRanksFileLoaded, this.onRanksLoadError);
            }
            else
            {
                if (Api.systemApi.getBuildType() == BuildTypeEnum.BETA)
                {
                    Api.fileApi.trustedLoadXmlFile((ADMIN_CONFIG_URL_BETA + "ranks.xml"), this.onRanksFileLoaded, this.onRanksLoadError);
                }
                else
                {
                    Api.fileApi.trustedLoadXmlFile((ADMIN_CONFIG_URL_RELEASE + "ranks.xml"), this.onRanksFileLoaded, this.onRanksLoadError);
                };
            };
        }

        public function process(replaceParam:Object):Array
        {
            var bi:BasicItem;
            var result:Array = [];
            for each (bi in this._menu)
            {
                if (bi.rank <= this._rank)
                {
                    result.push(bi.getContextMenuItem(replaceParam));
                };
            };
            return (result);
        }

        public function onStart():void
        {
            var cmdItem:SendCommandItem;
            var i:uint;
            while (i < this._startCmd.length)
            {
                cmdItem = this._startCmd[i];
                if (cmdItem)
                {
                    cmdItem.callbackFunction.apply(null, cmdItem.getcallbackArgs([]));
                };
                i++;
            };
        }

        private function parseNode(node:XMLNode, container:Array, rights:Array=null):void
        {
            var currentNode:XMLNode;
            var _local_5:BasicItem;
            for each (currentNode in node.childNodes)
            {
                if (((!(rights)) || (!((rights.indexOf(currentNode.nodeName) == -1)))))
                {
                    switch (currentNode.nodeName)
                    {
                        case "item":
                            _local_5 = this.parseItem(currentNode);
                            if (_local_5)
                            {
                                container.push(_local_5);
                            };
                            break;
                        case "move":
                            this.parseMove(currentNode, container);
                            break;
                        case "delete":
                            this.parseDelete(currentNode, container);
                            break;
                        case "add":
                            this.parseAdd(currentNode, container);
                            break;
                    };
                };
            };
        }

        private function parseItem(node:XMLNode):BasicItem
        {
            if (!(node.attributes["type"]))
            {
                return (null);
            };
            var item:BasicItem;
            switch (node.attributes["type"].toLowerCase())
            {
                case "static":
                    item = new BasicItem();
                    break;
                case "separator":
                    trace("parse separator");
                    item = new SeparatorItem();
                    break;
                case "sendcommand":
                    item = new SendCommandItem(node.attributes["command"], node.attributes["delay"], node.attributes["repeat"]);
                    break;
                case "sendchat":
                    item = new SendChatItem(node.attributes["command"], node.attributes["delay"], node.attributes["repeat"]);
                    break;
                case "preparecommand":
                    item = new PrepareCommanditem(node.attributes["command"], node.attributes["delay"], node.attributes["repeat"]);
                    break;
                case "batch":
                    item = new BatchItem(node.attributes["delay"], node.attributes["repeat"]);
                    this.parseNode(node, BatchItem(item).subItem);
                    break;
                case "menu":
                    item = new MenuItem();
                    this.parseNode(node, MenuItem(item).children);
                    break;
                case "startup":
                    this.parseNode(node, this._startCmd);
                    break;
                case "loadxml":
                    item = new ReloadXmlItem();
                    break;
            };
            if (item)
            {
                item.label = node.attributes["label"];
                item.help = node.attributes["help"];
                item.rank = node.attributes["rank"];
                return (item);
            };
            return (null);
        }

        private function parseMove(node:XMLNode, container:Array):void
        {
            var label:String = node.attributes["label"];
            var target:String = node.attributes["target"];
            var position:String = node.attributes["position"];
            var locateData:Object = this.locate(label, container);
            this.move(container, locateData, target, position);
        }

        private function parseDelete(node:XMLNode, container:Array):void
        {
            var label:String = node.attributes["label"];
            var locateData:Object = this.locate(label, container);
            this.move(container, locateData);
        }

        private function parseAdd(node:XMLNode, container:Array):void
        {
            var itemNode:XMLNode;
            var item:BasicItem;
            var target:String = node.attributes["target"];
            var position:String = node.attributes["position"];
            for each (itemNode in node.childNodes)
            {
                item = this.parseItem(itemNode);
                if (item)
                {
                    this.add(container, item, target, position);
                };
            };
        }

        private function move(container:Array, locateData:Object, target:String=null, position:String=null):void
        {
            var item:BasicItem = locateData.container[locateData.position];
            locateData.container.splice(locateData.position, 1);
            if (position)
            {
                this.add(container, item, target, position);
            };
        }

        private function add(container:Array, item:BasicItem, target:String=null, position:String=null):void
        {
            var node:BasicItem;
            var locateData:Object = this.locate(target, container);
            if (locateData.container)
            {
                node = locateData.container[locateData.position];
            };
            switch (position)
            {
                case "first":
                    if (!(node))
                    {
                        this._menu.unshift(item);
                    }
                    else
                    {
                        if ((node is MenuItem))
                        {
                            MenuItem(node).children.unshift(item);
                        };
                    };
                    break;
                case "last":
                    if (!(node))
                    {
                        this._menu.push(item);
                    }
                    else
                    {
                        if ((node is MenuItem))
                        {
                            MenuItem(node).children.push(item);
                        };
                    };
                    break;
                case "before":
                    locateData.container.splice(locateData.position, 0, item);
                    break;
                case "after":
                    locateData.container.splice((locateData.position + 1), 0, item);
                    break;
            };
        }

        private function locate(target:String, container:Array):Object
        {
            var item:BasicItem;
            var _local_5:Object;
            if (target == null)
            {
                return ({"container":null});
            };
            var i:int;
            while (i < container.length)
            {
                item = container[i];
                if (item.label == target)
                {
                    return ({
                        "container":container,
                        "position":i
                    });
                };
                switch (true)
                {
                    case (item is MenuItem):
                        _local_5 = this.locate(target, MenuItem(item).children);
                        if (_local_5)
                        {
                            return (_local_5);
                        };
                        break;
                };
                i++;
            };
            return (null);
        }

        private function onRanksFileLoaded(content:*):void
        {
            var currentNode:XMLNode;
            var rights:String;
            var server:Server;
            var baseUrl:String;
            var xmlDoc:XMLDocument = new XMLDocument(content.toString());
            xmlDoc.ignoreWhite = true;
            this._rank = 0;
            this._hierarchyString = null;
            if (((xmlDoc.firstChild) && (xmlDoc.firstChild.childNodes)))
            {
                for each (currentNode in xmlDoc.firstChild.childNodes)
                {
                    if (!!(currentNode.attributes["type"]))
                    {
                        trace(Api.systemApi.getAdminStatus());
                        if (GameHierarchyEnum[currentNode.attributes["type"].toUpperCase()] == Api.systemApi.getAdminStatus())
                        {
                            if (currentNode.attributes["level"] > this._rank)
                            {
                                if (Api.systemApi.hasAdminCommand(currentNode.attributes["command"]))
                                {
                                    this._rank = currentNode.attributes["level"];
                                    rights = currentNode.attributes["rights"];
                                    if (rights)
                                    {
                                        this._rights = rights.split(",");
                                    }
                                    else
                                    {
                                        this._rights = ["item", "add", "move", "remove"];
                                    };
                                };
                            };
                            this._hierarchyString = currentNode.attributes["type"].toUpperCase();
                        };
                    };
                };
            };
            if (this._hierarchyString)
            {
                server = Api.systemApi.getCurrentServer();
                if (Api.systemApi.getBuildType() >= BuildTypeEnum.INTERNAL)
                {
                    baseUrl = (((ADMIN_CONFIG_URL_INTERNAL + this._hierarchyString.toLowerCase()) + "_") + Api.systemApi.getCurrentLanguage());
                }
                else
                {
                    if (Api.systemApi.getBuildType() == BuildTypeEnum.BETA)
                    {
                        baseUrl = (((ADMIN_CONFIG_URL_BETA + this._hierarchyString.toLowerCase()) + "_") + Api.systemApi.getCurrentLanguage());
                    }
                    else
                    {
                        baseUrl = (((ADMIN_CONFIG_URL_RELEASE + this._hierarchyString.toLowerCase()) + "_") + Api.systemApi.getCurrentLanguage());
                    };
                };
                if (Api.systemApi.getBuildType() < BuildTypeEnum.INTERNAL)
                {
                    this._menuAdminUrls.push("ui/Ankama_Admin/menuadmin.xml");
                };
                this._menuAdminUrls.push((baseUrl + ".xml"));
                this._menuAdminUrls.push((((baseUrl + "_") + server.id) + ".xml"));
                if (Api.systemApi.getBuildType() >= BuildTypeEnum.INTERNAL)
                {
                    this._menuAdminUrls.push("ui/Ankama_Admin/menuadmin.xml");
                };
                Api.fileApi.trustedLoadXmlFile(this._menuAdminUrls.pop(), this.onFileLoaded, this.onLoadError);
            }
            else
            {
                Api.fileApi.loadXmlFile("menuadmin.xml", this.onFileLoaded, this.onLoadError);
            };
        }

        private function onFileLoaded(content:*):void
        {
            var server:Server;
            var xmlDoc:XMLDocument = new XMLDocument(content.toString());
            xmlDoc.ignoreWhite = true;
            this.parseNode(xmlDoc.firstChild, this._menu);
            if (this._hierarchyString)
            {
                server = Api.systemApi.getCurrentServer();
                Api.fileApi.loadXmlFile((((this._hierarchyString.toLowerCase() + "_") + server.community.shortId) + ".xml"), this.onOverwriteFileLoaded, this.onLoadError);
            };
        }

        private function onOverwriteFileLoaded(content:*):void
        {
            var xmlDoc:XMLDocument = new XMLDocument(content.toString());
            xmlDoc.ignoreWhite = true;
            this.parseNode(xmlDoc.firstChild, this._menu, this._rights);
        }

        private function onLoadError(errorCode:uint, errorMsg:String):void
        {
            if (this._menuAdminUrls.length)
            {
                Api.fileApi.trustedLoadXmlFile(this._menuAdminUrls.pop(), this.onFileLoaded, this.onLoadError);
            }
            else
            {
                Api.systemApi.log(0, ("Impossible de charger " + errorMsg));
            };
        }

        private function onRanksLoadError(errorCode:uint, errorMsg:String):void
        {
            Api.fileApi.loadXmlFile("menuadmin.xml", this.onFileLoaded, this.onLoadError);
        }


    }
}//package adminMenu

