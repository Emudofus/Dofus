package com.ankamagames.dofus.misc.utils.mapeditor
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.resources.adapters.*;
    import com.ankamagames.atouin.types.events.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class MapEditorManager extends Object
    {
        private var _mapEditorConnector:MapEditorConnector;
        private var _currentPopup:Sprite;
        private var _currentNpcInfos:MapComplementaryInformationsDataMessage;
        private var _currentRenderId:uint;
        private var _lastRenderedId:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MapEditorManager));
        private static const COLOR_CONNECTED:uint = 12579390;
        private static const COLOR_CLOSE:uint = 15892246;

        public function MapEditorManager()
        {
            if (BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
            {
                return;
            }
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this._mapEditorConnector = new MapEditorConnector();
            this._mapEditorConnector.addEventListener(MapEditorDataEvent.NEW_DATA, this.onNewData);
            this._mapEditorConnector.addEventListener(Event.CONNECT, this.onConnect);
            this._mapEditorConnector.addEventListener(Event.CLOSE, this.onClose);
            this._mapEditorConnector.addEventListener(ProgressEvent.SOCKET_DATA, this.onDataProgress);
            return;
        }// end function

        private function displayPopup(param1:String, param2:uint, param3:Boolean = false) : void
        {
            if (this._currentPopup)
            {
                this.closePopup();
            }
            this._currentPopup = new Sprite();
            this._currentPopup.mouseChildren = false;
            this._currentPopup.addEventListener(MouseEvent.CLICK, this.closePopup);
            var _loc_4:* = new TextField();
            new TextField().defaultTextFormat = new TextFormat("Verdana", 12, 0, true);
            _loc_4.autoSize = TextFieldAutoSize.LEFT;
            _loc_4.height = 30;
            _loc_4.text = param1;
            this._currentPopup.addChild(_loc_4);
            this._currentPopup.graphics.beginFill(param2);
            this._currentPopup.graphics.lineStyle(1, 6710886);
            this._currentPopup.graphics.drawRect(-5, -5, 20 + _loc_4.textWidth, _loc_4.height + 10);
            this._currentPopup.graphics.endFill();
            StageShareManager.stage.addChild(this._currentPopup);
            this._currentPopup.x = (StageShareManager.startWidth - _loc_4.textWidth) / 2;
            this._currentPopup.y = 10;
            if (param3)
            {
                setTimeout(this.closePopup, 5000, null, this._currentPopup);
            }
            return;
        }// end function

        private function closePopup(event:Event = null, param2:Sprite = null) : void
        {
            if (!param2)
            {
                param2 = this._currentPopup;
            }
            if (!param2)
            {
                return;
            }
            param2.removeEventListener(MouseEvent.CLICK, this.closePopup);
            if (param2.parent)
            {
                param2.parent.removeChild(param2);
            }
            if (param2 == this._currentPopup)
            {
                this._currentPopup = null;
            }
            return;
        }// end function

        private function onNewData(event:MapEditorDataEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            this.displayPopup("Données provenant de l\'éditeur " + event.data.type, COLOR_CONNECTED);
            switch(event.data.type)
            {
                case MapEditorMessage.MESSAGE_TYPE_DLM:
                {
                    this.displayPopup("Rendu d\'une map provenant de l\'éditeur", COLOR_CONNECTED);
                    _log.info("Rendu d\'une map provenant de l\'éditeur");
                    _loc_2 = new MapsAdapter();
                    _loc_2.loadFromData(new Uri(), event.data.data, new ResourceObserverWrapper(this.onDmlLoaded), false);
                    break;
                }
                case MapEditorMessage.MESSAGE_TYPE_ELE:
                {
                    this.displayPopup("Donnée sur les éléments", COLOR_CONNECTED);
                    _log.info("Parsing du fichier .ele provenant de l\'éditeur");
                    _loc_3 = new ElementsAdapter();
                    _loc_3.loadFromData(new Uri(), event.data.data, new ResourceObserverWrapper(), false);
                    break;
                }
                case MapEditorMessage.MESSAGE_TYPE_NPC:
                {
                    _loc_4 = event.data.data.readInt();
                    _loc_5 = event.data.data.readInt();
                    _loc_6 = new Vector.<GameRolePlayActorInformations>;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_5)
                    {
                        
                        _loc_10 = new GameRolePlayNpcInformations();
                        _loc_11 = event.data.data.readShort();
                        _loc_12 = event.data.data.readInt();
                        _loc_13 = event.data.data.readByte();
                        _loc_14 = new EntityDispositionInformations();
                        _loc_14.initEntityDispositionInformations(_loc_11, _loc_13);
                        _loc_10.initGameRolePlayNpcInformations(_loc_12, EntityLookAdapter.toNetwork(TiphonEntityLook.fromString(Npc.getNpcById(_loc_12).look)), _loc_14, _loc_12);
                        _loc_6.push(_loc_10);
                        _loc_9 = _loc_9 + 1;
                    }
                    _loc_7 = new MapComplementaryInformationsDataMessage();
                    _loc_8 = SubArea.getSubAreaByMapId(_loc_4);
                    _loc_7.initMapComplementaryInformationsDataMessage(_loc_8 ? (_loc_8.id) : (0), _loc_4, 0, new Vector.<HouseInformations>, _loc_6, new Vector.<InteractiveElement>, new Vector.<StatedElement>, new Vector.<MapObstacle>, new Vector.<FightCommonInformations>);
                    if (this._lastRenderedId == MapDisplayManager.getInstance().currentRenderId)
                    {
                        Kernel.getWorker().process(_loc_7);
                        this._currentNpcInfos = null;
                    }
                    else
                    {
                        this._currentNpcInfos = _loc_7;
                    }
                    break;
                }
                case MapEditorMessage.MESSAGE_TYPE_HELLO:
                {
                    this.displayPopup("Hello Alea", COLOR_CONNECTED);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onMapRenderEnd(event:RenderMapEvent) : void
        {
            this._lastRenderedId = event.renderId;
            if (this._currentNpcInfos && event.renderId == this._currentRenderId)
            {
                Kernel.getWorker().process(this._currentNpcInfos);
                this._currentNpcInfos = null;
            }
            this.displayPopup("Taille des picto : " + StringUtils.formateIntToString(uint(MapDisplayManager.getInstance().renderer.gfxMemorySize / 1024)) + " Ko", COLOR_CONNECTED);
            return;
        }// end function

        private function onDmlLoaded(param1:Uri, param2:uint, param3) : void
        {
            MapDisplayManager.getInstance().renderer.useDefautState = true;
            var _loc_4:* = new Map();
            new Map().fromRaw(param3);
            this._currentRenderId = MapDisplayManager.getInstance().fromMap(_loc_4);
            return;
        }// end function

        private function onConnect(event:Event) : void
        {
            this.displayPopup("Connecté à l\'éditeur", COLOR_CONNECTED);
            _log.info("Connecté à l\'éditeur de map");
            MapDisplayManager.getInstance().renderer.addEventListener(RenderMapEvent.MAP_RENDER_END, this.onMapRenderEnd);
            return;
        }// end function

        private function onDataProgress(event:Event) : void
        {
            this.displayPopup("Réception de données", COLOR_CONNECTED);
            _log.info("Réception de données");
            return;
        }// end function

        private function onClose(event:Event) : void
        {
            this.displayPopup("Connexion à l\'éditeur de map perdue", COLOR_CLOSE);
            _log.info("Connexion à l\'éditeur de map perdue");
            return;
        }// end function

    }
}
