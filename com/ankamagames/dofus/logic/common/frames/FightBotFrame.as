package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.Timer;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapFightCountMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightReadyMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import flash.events.Event;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnFinishMessage;
   import flash.utils.setTimeout;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.pools.GenericPool;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastRequestMessage;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.events.TimerEvent;
   
   public class FightBotFrame extends Object implements Frame
   {
      
      public function FightBotFrame() {
         this._rollOverTimer = new Timer(2000);
         this._actionTimer = new Timer(5000);
         this._turnAction = [];
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this.initRight();
            this._actionTimer.addEventListener(TimerEvent.TIMER,this.onAction);
            this._rollOverTimer.addEventListener(TimerEvent.TIMER,this.randomOver);
            return;
         }
      }
      
      private static var _self:FightBotFrame;
      
      public static function getInstance() : FightBotFrame {
         if(!_self)
         {
            _self = new FightBotFrame();
         }
         return _self;
      }
      
      private var _frameFightListRequest:Boolean;
      
      private var _fightCount:uint;
      
      private var _mapPos:Array;
      
      private var _enabled:Boolean;
      
      private var _rollOverTimer:Timer;
      
      private var _actionTimer:Timer;
      
      private var _inFight:Boolean;
      
      private var _lastElemOver:Sprite;
      
      private var _lastEntityOver:IInteractive;
      
      private var _wait:Boolean;
      
      private var _turnPlayed:uint;
      
      private var _myTurn:Boolean;
      
      public function pushed() : Boolean {
         this._enabled = true;
         this.fakeActivity();
         this._myTurn = false;
         this._actionTimer.start();
         this._rollOverTimer.start();
         this._mapPos = MapPosition.getMapPositions();
         var _loc1_:MapFightCountMessage = new MapFightCountMessage();
         _loc1_.initMapFightCountMessage(1);
         this.process(_loc1_);
         return true;
      }
      
      public function pulled() : Boolean {
         this._rollOverTimer.stop();
         this._actionTimer.stop();
         this._enabled = false;
         return true;
      }
      
      public function get priority() : int {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function get fightCount() : uint {
         return this._fightCount;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameFightReadyMessage = null;
         var _loc3_:GameFightTurnStartMessage = null;
         switch(true)
         {
            case param1 is GameFightJoinMessage:
               this._fightCount++;
               this._inFight = true;
               break;
            case param1 is GameFightEndMessage:
               this._inFight = false;
               break;
            case param1 is MapComplementaryInformationsDataMessage:
               this._wait = false;
               break;
            case param1 is MapsLoadingStartedMessage:
               this._wait = true;
               break;
            case param1 is GameFightShowFighterMessage:
               this.sendAdminCmd("givelife *");
               this.sendAdminCmd("giveenergy *");
               this._turnPlayed = 0;
               this._myTurn = false;
               _loc2_ = new GameFightReadyMessage();
               _loc2_.initGameFightReadyMessage(true);
               ConnectionsHandler.getConnection().send(_loc2_);
               break;
            case param1 is GameFightTurnStartMessage:
               _loc3_ = param1 as GameFightTurnStartMessage;
               this._turnAction = [];
               if(_loc3_.id == PlayedCharacterManager.getInstance().id)
               {
                  this._myTurn = true;
                  this._turnPlayed++;
                  if(this._turnPlayed > 2)
                  {
                     this.castSpell(411,true);
                  }
                  else
                  {
                     this.addTurnAction(this.fightRandomMove,[]);
                     this.addTurnAction(this.castSpell,[173,false]);
                     this.addTurnAction(this.castSpell,[173,false]);
                     this.addTurnAction(this.castSpell,[173,false]);
                     this.addTurnAction(this.turnEnd,[]);
                     this.nextTurnAction();
                  }
               }
               else
               {
                  this._myTurn = false;
               }
               break;
            case param1 is SequenceEndMessage:
               this.nextTurnAction();
               break;
         }
         return false;
      }
      
      private function initRight() : void {
         this.sendAdminCmd("adminaway");
         this.sendAdminCmd("givelevel * 200");
         this.sendAdminCmd("givespell * 173 6");
         this.sendAdminCmd("givespell * 411 6");
         this.sendAdminCmd("dring po=63,vita=8000,pa=100,agi=150 true");
      }
      
      private function sendAdminCmd(param1:String) : void {
         var _loc2_:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         _loc2_.initAdminQuietCommandMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      private function onAction(param1:Event) : void {
         if(Math.random() < 0.9)
         {
            this.randomWalk();
         }
         else
         {
            this.randomMove();
         }
      }
      
      private var _turnAction:Array;
      
      private function nextTurnAction() : void {
         var _loc1_:Object = null;
         if(this._turnAction.length)
         {
            _loc1_ = this._turnAction.shift();
            _loc1_.fct.apply(this,_loc1_.args);
         }
      }
      
      private function addTurnAction(param1:Function, param2:Array) : void {
         this._turnAction.push(
            {
               "fct":param1,
               "args":param2
            });
      }
      
      private function turnEnd() : void {
         var _loc1_:GameFightTurnFinishMessage = new GameFightTurnFinishMessage();
         _loc1_.initGameFightTurnFinishMessage();
         ConnectionsHandler.getConnection().send(_loc1_);
      }
      
      private function join(param1:String) : void {
         if((this._inFight) || (this._wait))
         {
            return;
         }
         var _loc2_:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         _loc2_.initAdminQuietCommandMessage("join " + param1);
         ConnectionsHandler.getConnection().send(_loc2_);
         this._actionTimer.reset();
         this._actionTimer.start();
      }
      
      private function randomMove() : void {
         if((this._inFight) || (this._wait))
         {
            return;
         }
         var _loc1_:MapPosition = this._mapPos[int(Math.random() * this._mapPos.length)];
         var _loc2_:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         _loc2_.initAdminQuietCommandMessage("moveto " + _loc1_.id);
         ConnectionsHandler.getConnection().send(_loc2_);
         this._actionTimer.reset();
         this._actionTimer.start();
      }
      
      private function fakeActivity() : void {
         if(!this._enabled)
         {
            return;
         }
         setTimeout(this.fakeActivity,1000 * 60 * 5);
         var _loc1_:BasicPingMessage = new BasicPingMessage();
         _loc1_.initBasicPingMessage(false);
         ConnectionsHandler.getConnection().send(_loc1_);
      }
      
      private function randomWalk() : void {
         var _loc3_:* = undefined;
         var _loc5_:IEntity = null;
         if((this._inFight) || (this._wait))
         {
            return;
         }
         var _loc1_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Array = [];
         for each (_loc3_ in _loc1_.getEntitiesDictionnary())
         {
            if(_loc3_ is GameRolePlayGroupMonsterInformations)
            {
               _loc5_ = DofusEntities.getEntity(GameRolePlayGroupMonsterInformations(_loc3_).contextualId);
               _loc2_.push(MapPoint.fromCellId(_loc5_.position.cellId));
            }
         }
         if(!_loc2_ || !_loc2_.length)
         {
            return;
         }
         var _loc4_:CellClickMessage = new CellClickMessage();
         _loc4_.cell = _loc2_[Math.floor(_loc2_.length * Math.random())];
         _loc4_.cellId = _loc4_.cell.cellId;
         _loc4_.id = MapDisplayManager.getInstance().currentMapPoint.mapId;
         Kernel.getWorker().process(_loc4_);
      }
      
      private function fightRandomMove() : void {
         var _loc1_:FightReachableCellsMaker = new FightReachableCellsMaker(FightEntitiesFrame.getCurrentInstance().getEntityInfos(PlayedCharacterManager.getInstance().id) as GameFightFighterInformations);
         if(!_loc1_.reachableCells.length)
         {
            this.nextTurnAction();
            return;
         }
         var _loc2_:CellClickMessage = new CellClickMessage();
         _loc2_.cell = MapPoint.fromCellId(_loc1_.reachableCells[Math.floor(_loc1_.reachableCells.length * Math.random())]);
         _loc2_.cellId = _loc2_.cell.cellId;
         _loc2_.id = MapDisplayManager.getInstance().currentMapPoint.mapId;
         Kernel.getWorker().process(_loc2_);
      }
      
      private function randomOver(... rest) : void {
         var _loc3_:IEntity = null;
         var _loc4_:IInteractive = null;
         var _loc7_:UiRootContainer = null;
         var _loc10_:EntityMouseOutMessage = null;
         var _loc11_:GraphicContainer = null;
         var _loc12_:MouseOutMessage = null;
         if(this._wait)
         {
            return;
         }
         var _loc2_:Array = [];
         for each (_loc3_ in EntitiesManager.getInstance().entities)
         {
            if(_loc3_ is IInteractive)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc4_ = _loc2_[Math.floor(_loc2_.length * Math.random())];
         if(!_loc4_)
         {
            return;
         }
         if(this._lastEntityOver)
         {
            _loc10_ = new EntityMouseOutMessage(this._lastEntityOver);
            Kernel.getWorker().process(_loc10_);
         }
         this._lastEntityOver = _loc4_;
         var _loc5_:EntityMouseOverMessage = new EntityMouseOverMessage(_loc4_);
         Kernel.getWorker().process(_loc5_);
         var _loc6_:Array = [];
         for each (_loc7_ in Berilia.getInstance().uiList)
         {
            for each (_loc11_ in _loc7_.getElements())
            {
               if((_loc11_.mouseChildren) || (_loc11_.mouseEnabled))
               {
                  _loc6_.push(_loc11_);
               }
            }
         }
         if(!_loc6_.length)
         {
            return;
         }
         if(this._lastElemOver)
         {
            _loc12_ = GenericPool.get(MouseOutMessage,this._lastElemOver,new MouseEvent(MouseEvent.MOUSE_OUT));
            Kernel.getWorker().process(_loc12_);
         }
         var _loc8_:GraphicContainer = _loc6_[Math.floor(_loc6_.length * Math.random())];
         var _loc9_:MouseOverMessage = GenericPool.get(MouseOverMessage,_loc8_,new MouseEvent(MouseEvent.MOUSE_OVER));
         Kernel.getWorker().process(_loc9_);
         this._lastElemOver = _loc8_;
      }
      
      private function castSpell(param1:uint, param2:Boolean) : void {
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:* = undefined;
         var _loc7_:GameFightMonsterInformations = null;
         var _loc3_:GameActionFightCastRequestMessage = new GameActionFightCastRequestMessage();
         if(param2)
         {
            _loc4_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(PlayedCharacterManager.getInstance().id).disposition.cellId;
         }
         else
         {
            _loc5_ = [];
            for each (_loc6_ in FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary())
            {
               if(_loc6_.contextualId < 0 && _loc6_ is GameFightMonsterInformations)
               {
                  _loc7_ = _loc6_ as GameFightMonsterInformations;
                  if(_loc7_.alive)
                  {
                     _loc5_.push(_loc6_.disposition.cellId);
                  }
               }
            }
            _loc4_ = _loc5_[Math.floor(_loc5_.length * Math.random())];
         }
         _loc3_.initGameActionFightCastRequestMessage(param1,_loc4_);
         ConnectionsHandler.getConnection().send(_loc3_);
      }
   }
}
