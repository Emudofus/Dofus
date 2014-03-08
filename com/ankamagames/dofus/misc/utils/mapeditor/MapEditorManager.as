package com.ankamagames.dofus.misc.utils.mapeditor
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.Sprite;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
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
   import com.ankamagames.atouin.types.events.RenderMapEvent;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class MapEditorManager extends Object
   {
      
      public function MapEditorManager() {
         super();
         if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
         {
            return;
         }
         this.init();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapEditorManager));
      
      private static const COLOR_CONNECTED:uint = 12579390;
      
      private static const COLOR_CLOSE:uint = 15892246;
      
      private var _mapEditorConnector:MapEditorConnector;
      
      private var _currentPopup:Sprite;
      
      private var _currentNpcInfos:MapComplementaryInformationsDataMessage;
      
      private function init() : void {
         this._mapEditorConnector = new MapEditorConnector();
         this._mapEditorConnector.addEventListener(MapEditorDataEvent.NEW_DATA,this.onNewData);
         this._mapEditorConnector.addEventListener(Event.CONNECT,this.onConnect);
         this._mapEditorConnector.addEventListener(Event.CLOSE,this.onClose);
         this._mapEditorConnector.addEventListener(ProgressEvent.SOCKET_DATA,this.onDataProgress);
      }
      
      private function displayPopup(param1:String, param2:uint, param3:Boolean=false) : void {
         if(this._currentPopup)
         {
            this.closePopup();
         }
         this._currentPopup = new Sprite();
         this._currentPopup.mouseChildren = false;
         this._currentPopup.addEventListener(MouseEvent.CLICK,this.closePopup);
         var _loc4_:TextField = new TextField();
         _loc4_.defaultTextFormat = new TextFormat("Verdana",12,0,true);
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.height = 30;
         _loc4_.text = param1;
         this._currentPopup.addChild(_loc4_);
         this._currentPopup.graphics.beginFill(param2);
         this._currentPopup.graphics.lineStyle(1,6710886);
         this._currentPopup.graphics.drawRect(-5,-5,20 + _loc4_.textWidth,_loc4_.height + 10);
         this._currentPopup.graphics.endFill();
         StageShareManager.stage.addChild(this._currentPopup);
         this._currentPopup.x = (StageShareManager.startWidth - _loc4_.textWidth) / 2;
         this._currentPopup.y = 10;
         if(param3)
         {
            setTimeout(this.closePopup,5000,null,this._currentPopup);
         }
      }
      
      private function closePopup(param1:Event=null, param2:Sprite=null) : void {
         if(!param2)
         {
            param2 = this._currentPopup;
         }
         if(!param2)
         {
            return;
         }
         param2.removeEventListener(MouseEvent.CLICK,this.closePopup);
         if(param2.parent)
         {
            param2.parent.removeChild(param2);
         }
         if(param2 == this._currentPopup)
         {
            this._currentPopup = null;
         }
      }
      
      private function onNewData(param1:MapEditorDataEvent) : void {
         var _loc2_:MapsAdapter = null;
         var _loc3_:ElementsAdapter = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Vector.<GameRolePlayActorInformations> = null;
         var _loc7_:MapComplementaryInformationsDataMessage = null;
         var _loc8_:SubArea = null;
         var _loc9_:uint = 0;
         var _loc10_:GameRolePlayNpcInformations = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:EntityDispositionInformations = null;
         this.displayPopup("Données provenant de l\'éditeur " + param1.data.type,COLOR_CONNECTED);
         switch(param1.data.type)
         {
            case MapEditorMessage.MESSAGE_TYPE_DLM:
               this.displayPopup("Rendu d\'une map provenant de l\'éditeur",COLOR_CONNECTED);
               _log.info("Rendu d\'une map provenant de l\'éditeur");
               _loc2_ = new MapsAdapter();
               _loc2_.loadFromData(new Uri(),param1.data.data,new ResourceObserverWrapper(this.onDmlLoaded),false);
               break;
            case MapEditorMessage.MESSAGE_TYPE_ELE:
               this.displayPopup("Donnée sur les éléments",COLOR_CONNECTED);
               _log.info("Parsing du fichier .ele provenant de l\'éditeur");
               _loc3_ = new ElementsAdapter();
               _loc3_.loadFromData(new Uri(),param1.data.data,new ResourceObserverWrapper(),false);
               break;
            case MapEditorMessage.MESSAGE_TYPE_NPC:
               _loc4_ = param1.data.data.readInt();
               _loc5_ = param1.data.data.readInt();
               _loc6_ = new Vector.<GameRolePlayActorInformations>();
               _loc9_ = 0;
               while(_loc9_ < _loc5_)
               {
                  _loc10_ = new GameRolePlayNpcInformations();
                  _loc11_ = param1.data.data.readShort();
                  _loc12_ = param1.data.data.readInt();
                  _loc13_ = param1.data.data.readByte();
                  _loc14_ = new EntityDispositionInformations();
                  _loc14_.initEntityDispositionInformations(_loc11_,_loc13_);
                  _loc10_.initGameRolePlayNpcInformations(_loc12_,EntityLookAdapter.toNetwork(TiphonEntityLook.fromString(Npc.getNpcById(_loc12_).look)),_loc14_,_loc12_);
                  _loc6_.push(_loc10_);
                  _loc9_++;
               }
               _loc7_ = new MapComplementaryInformationsDataMessage();
               _loc8_ = SubArea.getSubAreaByMapId(_loc4_);
               _loc7_.initMapComplementaryInformationsDataMessage(_loc8_?_loc8_.id:0,_loc4_,new Vector.<HouseInformations>(),_loc6_,new Vector.<InteractiveElement>(),new Vector.<StatedElement>(),new Vector.<MapObstacle>(),new Vector.<FightCommonInformations>());
               if(this._lastRenderedId == MapDisplayManager.getInstance().currentRenderId)
               {
                  Kernel.getWorker().process(_loc7_);
                  this._currentNpcInfos = null;
               }
               else
               {
                  this._currentNpcInfos = _loc7_;
               }
               break;
            case MapEditorMessage.MESSAGE_TYPE_HELLO:
               this.displayPopup("Hello Alea",COLOR_CONNECTED);
               break;
         }
      }
      
      private var _currentRenderId:uint;
      
      private var _lastRenderedId:uint;
      
      private function onMapRenderEnd(param1:RenderMapEvent) : void {
         this._lastRenderedId = param1.renderId;
         if((this._currentNpcInfos) && param1.renderId == this._currentRenderId)
         {
            Kernel.getWorker().process(this._currentNpcInfos);
            this._currentNpcInfos = null;
         }
         this.displayPopup("Taille des picto : " + StringUtils.formateIntToString(uint(MapDisplayManager.getInstance().renderer.gfxMemorySize / 1024)) + " Ko",COLOR_CONNECTED);
      }
      
      private function onDmlLoaded(param1:Uri, param2:uint, param3:*) : void {
         MapDisplayManager.getInstance().renderer.useDefautState = true;
         var _loc4_:Map = new Map();
         _loc4_.fromRaw(param3);
         this._currentRenderId = MapDisplayManager.getInstance().fromMap(_loc4_);
      }
      
      private function onConnect(param1:Event) : void {
         this.displayPopup("Connecté à l\'éditeur",COLOR_CONNECTED);
         _log.info("Connecté à l\'éditeur de map");
         MapDisplayManager.getInstance().renderer.addEventListener(RenderMapEvent.MAP_RENDER_END,this.onMapRenderEnd);
      }
      
      private function onDataProgress(param1:Event) : void {
         this.displayPopup("Réception de données",COLOR_CONNECTED);
         _log.info("Réception de données");
      }
      
      private function onClose(param1:Event) : void {
         this.displayPopup("Connexion à l\'éditeur de map perdue",COLOR_CLOSE);
         _log.info("Connexion à l\'éditeur de map perdue");
      }
   }
}
