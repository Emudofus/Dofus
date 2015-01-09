package com.ankamagames.dofus.misc.utils.mapeditor
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.display.Sprite;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.utils.setTimeout;
    import com.ankamagames.atouin.resources.adapters.MapsAdapter;
    import com.ankamagames.atouin.resources.adapters.ElementsAdapter;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.datacenter.npcs.Npc;
    import com.ankamagames.dofus.network.types.game.house.HouseInformations;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.atouin.types.events.RenderMapEvent;
    import com.ankamagames.atouin.data.map.Map;
    import __AS3__.vec.*;

    public class MapEditorManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapEditorManager));
        private static const COLOR_CONNECTED:uint = 12579390;
        private static const COLOR_CLOSE:uint = 15892246;

        private var _mapEditorConnector:MapEditorConnector;
        private var _currentPopup:Sprite;
        private var _currentNpcInfos:MapComplementaryInformationsDataMessage;
        private var _currentRenderId:uint;
        private var _lastRenderedId:uint;

        public function MapEditorManager()
        {
            if (BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
            {
                return;
            };
            this.init();
        }

        private function init():void
        {
            this._mapEditorConnector = new MapEditorConnector();
            this._mapEditorConnector.addEventListener(MapEditorDataEvent.NEW_DATA, this.onNewData);
            this._mapEditorConnector.addEventListener(Event.CONNECT, this.onConnect);
            this._mapEditorConnector.addEventListener(Event.CLOSE, this.onClose);
            this._mapEditorConnector.addEventListener(ProgressEvent.SOCKET_DATA, this.onDataProgress);
        }

        private function displayPopup(txt:String, color:uint, autoClose:Boolean=false):void
        {
            if (this._currentPopup)
            {
                this.closePopup();
            };
            this._currentPopup = new Sprite();
            this._currentPopup.mouseChildren = false;
            this._currentPopup.addEventListener(MouseEvent.CLICK, this.closePopup);
            var tf:TextField = new TextField();
            tf.defaultTextFormat = new TextFormat("Verdana", 12, 0, true);
            tf.autoSize = TextFieldAutoSize.LEFT;
            tf.height = 30;
            tf.text = txt;
            this._currentPopup.addChild(tf);
            this._currentPopup.graphics.beginFill(color);
            this._currentPopup.graphics.lineStyle(1, 0x666666);
            this._currentPopup.graphics.drawRect(-5, -5, (20 + tf.textWidth), (tf.height + 10));
            this._currentPopup.graphics.endFill();
            StageShareManager.stage.addChild(this._currentPopup);
            this._currentPopup.x = ((StageShareManager.startWidth - tf.textWidth) / 2);
            this._currentPopup.y = 10;
            if (autoClose)
            {
                setTimeout(this.closePopup, 5000, null, this._currentPopup);
            };
        }

        private function closePopup(e:Event=null, currentPopup:Sprite=null):void
        {
            if (!(currentPopup))
            {
                currentPopup = this._currentPopup;
            };
            if (!(currentPopup))
            {
                return;
            };
            currentPopup.removeEventListener(MouseEvent.CLICK, this.closePopup);
            if (currentPopup.parent)
            {
                currentPopup.parent.removeChild(currentPopup);
            };
            if (currentPopup == this._currentPopup)
            {
                this._currentPopup = null;
            };
        }

        private function onNewData(e:MapEditorDataEvent):void
        {
            var _local_2:MapsAdapter;
            var _local_3:ElementsAdapter;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:Vector.<GameRolePlayActorInformations>;
            var _local_7:MapComplementaryInformationsDataMessage;
            var _local_8:SubArea;
            var npcInd:uint;
            var npcInfo:GameRolePlayNpcInformations;
            var cellId:int;
            var npcId:int;
            var direction:int;
            var entityDisposition:EntityDispositionInformations;
            this.displayPopup(("Données provenant de l'éditeur " + e.data.type), COLOR_CONNECTED);
            switch (e.data.type)
            {
                case MapEditorMessage.MESSAGE_TYPE_DLM:
                    this.displayPopup("Rendu d'une map provenant de l'éditeur", COLOR_CONNECTED);
                    _log.info("Rendu d'une map provenant de l'éditeur");
                    _local_2 = new MapsAdapter();
                    _local_2.loadFromData(new Uri(), e.data.data, new ResourceObserverWrapper(this.onDmlLoaded), false);
                    return;
                case MapEditorMessage.MESSAGE_TYPE_ELE:
                    this.displayPopup("Donnée sur les éléments", COLOR_CONNECTED);
                    _log.info("Parsing du fichier .ele provenant de l'éditeur");
                    _local_3 = new ElementsAdapter();
                    _local_3.loadFromData(new Uri(), e.data.data, new ResourceObserverWrapper(), false);
                    return;
                case MapEditorMessage.MESSAGE_TYPE_NPC:
                    _local_4 = e.data.data.readInt();
                    _local_5 = e.data.data.readInt();
                    _local_6 = new Vector.<GameRolePlayActorInformations>();
                    npcInd = 0;
                    while (npcInd < _local_5)
                    {
                        npcInfo = new GameRolePlayNpcInformations();
                        cellId = e.data.data.readShort();
                        npcId = e.data.data.readInt();
                        direction = e.data.data.readByte();
                        entityDisposition = new EntityDispositionInformations();
                        entityDisposition.initEntityDispositionInformations(cellId, direction);
                        npcInfo.initGameRolePlayNpcInformations(npcId, EntityLookAdapter.toNetwork(TiphonEntityLook.fromString(Npc.getNpcById(npcId).look)), entityDisposition, npcId);
                        _local_6.push(npcInfo);
                        npcInd++;
                    };
                    _local_7 = new MapComplementaryInformationsDataMessage();
                    _local_8 = SubArea.getSubAreaByMapId(_local_4);
                    _local_7.initMapComplementaryInformationsDataMessage(((_local_8) ? _local_8.id : (0)), _local_4, new Vector.<HouseInformations>(), _local_6, new Vector.<InteractiveElement>(), new Vector.<StatedElement>(), new Vector.<MapObstacle>(), new Vector.<FightCommonInformations>());
                    if (this._lastRenderedId == MapDisplayManager.getInstance().currentRenderId)
                    {
                        Kernel.getWorker().process(_local_7);
                        this._currentNpcInfos = null;
                    }
                    else
                    {
                        this._currentNpcInfos = _local_7;
                    };
                    return;
                case MapEditorMessage.MESSAGE_TYPE_HELLO:
                    this.displayPopup("Hello Alea", COLOR_CONNECTED);
                    return;
            };
        }

        private function onMapRenderEnd(e:RenderMapEvent):void
        {
            this._lastRenderedId = e.renderId;
            if (((this._currentNpcInfos) && ((e.renderId == this._currentRenderId))))
            {
                Kernel.getWorker().process(this._currentNpcInfos);
                this._currentNpcInfos = null;
            };
            this.displayPopup((("Taille des picto : " + StringUtils.formateIntToString(uint((MapDisplayManager.getInstance().renderer.gfxMemorySize / 0x0400)))) + " Ko"), COLOR_CONNECTED);
        }

        private function onDmlLoaded(uri:Uri, resourceType:uint, resource:*):void
        {
            MapDisplayManager.getInstance().renderer.useDefautState = true;
            var map:Map = new Map();
            map.fromRaw(resource);
            this._currentRenderId = MapDisplayManager.getInstance().fromMap(map);
        }

        private function onConnect(e:Event):void
        {
            this.displayPopup("Connecté à l'éditeur", COLOR_CONNECTED);
            _log.info("Connecté à l'éditeur de map");
            MapDisplayManager.getInstance().renderer.addEventListener(RenderMapEvent.MAP_RENDER_END, this.onMapRenderEnd);
        }

        private function onDataProgress(e:Event):void
        {
            this.displayPopup("Réception de données", COLOR_CONNECTED);
            _log.info("Réception de données");
        }

        private function onClose(e:Event):void
        {
            this.displayPopup("Connexion à l'éditeur de map perdue", COLOR_CLOSE);
            _log.info("Connexion à l'éditeur de map perdue");
        }


    }
}//package com.ankamagames.dofus.misc.utils.mapeditor

