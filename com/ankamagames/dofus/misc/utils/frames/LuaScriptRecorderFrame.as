package com.ankamagames.dofus.misc.utils.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.console.moduleLUA.ConsoleLUA;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatServerMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowActorMessage;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseEndedMessage;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.ChatSmileyMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.console.moduleLUA.LuaMoveEnum;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class LuaScriptRecorderFrame extends Object implements Frame
   {
      
      public function LuaScriptRecorderFrame() {
         super();
      }
      
      private static var resourceID:int = 0;
      
      private var _luaScript:String = "";
      
      private var _playerId:int;
      
      private var _playerX:int;
      
      private var _playerY:int;
      
      private var _paused:Boolean;
      
      private var _running:Boolean = false;
      
      private var _autoTimer:Boolean;
      
      private var _moveType:int = 0;
      
      private var _mainSeqStartTime:int;
      
      private var _waitStartTime:int;
      
      private var _charMoveStartTime:int;
      
      private var _waitModTime:int = 0;
      
      private var _elementID:uint;
      
      private var _currentCell:MapPoint;
      
      private var _currentCameraZoom:int;
      
      private function addScriptLine(param1:String, param2:Boolean=false) : void {
         var _loc3_:* = 0;
         if(!this._paused && (this._running) || (param2))
         {
            if(this._luaScript != "")
            {
               this._luaScript = this._luaScript + "\n";
            }
            if(this._autoTimer)
            {
               if(!this._waitStartTime)
               {
                  this._waitStartTime = this._mainSeqStartTime;
               }
               _loc3_ = getTimer();
               if(this._charMoveStartTime)
               {
                  param1 = "seq.add(player.wait(" + String(this._charMoveStartTime - this._waitStartTime) + "))\n" + param1;
               }
               else
               {
                  param1 = "seq.add(player.wait(" + String(_loc3_ - this._waitStartTime) + "))\n" + param1;
               }
               this._charMoveStartTime = 0;
               this._waitModTime = 0;
               this._waitStartTime = getTimer();
            }
            this._luaScript = this._luaScript + param1;
            ConsoleLUA.getInstance().printLine(param1);
         }
      }
      
      public function pushed() : Boolean {
         InteractiveCellManager.getInstance().cellOverEnabled = true;
         this._currentCameraZoom = 1;
         return true;
      }
      
      public function pulled() : Boolean {
         InteractiveCellManager.getInstance().cellOverEnabled = false;
         this.stop();
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:GameMapMovementMessage = null;
         var _loc6_:EntityMovementCompleteMessage = null;
         var _loc7_:ChatServerMessage = null;
         var _loc8_:GameMapChangeOrientationMessage = null;
         var _loc9_:EmotePlayMessage = null;
         var _loc10_:GameRolePlayShowActorMessage = null;
         var _loc11_:TiphonEntityLook = null;
         var _loc12_:InteractiveUsedMessage = null;
         var _loc13_:InteractiveUseEndedMessage = null;
         var _loc14_:ChatSmileyMessage = null;
         var _loc15_:CellOverMessage = null;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = false;
         var _loc20_:RoleplayInteractivesFrame = null;
         var _loc21_:IEntity = null;
         var _loc22_:String = null;
         var _loc23_:MapPoint = null;
         var _loc24_:uint = 0;
         var _loc4_:* = false;
         switch(true)
         {
            case param1 is GameMapMovementMessage:
               _loc5_ = param1 as GameMapMovementMessage;
               if(_loc5_.actorId == this._playerId)
               {
                  this._charMoveStartTime = getTimer();
               }
               return false;
            case param1 is EntityMovementCompleteMessage:
               _loc6_ = param1 as EntityMovementCompleteMessage;
               if(_loc6_.entity.id == this._playerId)
               {
                  switch(this._moveType)
                  {
                     case LuaMoveEnum.MOVE_DEFAULT:
                        _loc2_ = "move";
                        break;
                     case LuaMoveEnum.MOVE_WALK:
                        _loc2_ = "walk";
                        break;
                     case LuaMoveEnum.MOVE_RUN:
                        _loc2_ = "run";
                        break;
                     case LuaMoveEnum.MOVE_TELEPORT:
                        _loc2_ = "teleport";
                        break;
                     case LuaMoveEnum.MOVE_SLIDE:
                        _loc2_ = "slide";
                        break;
                  }
                  _loc3_ = _loc6_.entity.position.x + ", " + _loc6_.entity.position.y;
                  this._playerX = _loc6_.entity.position.x;
                  this._playerY = _loc6_.entity.position.y;
                  break;
               }
               return false;
            case param1 is ChatServerMessage:
               _loc7_ = param1 as ChatServerMessage;
               if(_loc7_.senderId == this._playerId)
               {
                  _loc4_ = true;
                  if(_loc7_.content.substr(0,6).toLowerCase() == "/think")
                  {
                     _loc2_ = "think";
                     _loc3_ = _loc7_.content.substr(7);
                  }
                  else
                  {
                     _loc2_ = "speak";
                     _loc3_ = _loc7_.content;
                  }
                  break;
               }
               return false;
            case param1 is GameMapChangeOrientationMessage:
               _loc8_ = param1 as GameMapChangeOrientationMessage;
               if(_loc8_.orientation.id == this._playerId)
               {
                  _loc2_ = "setDirection";
                  _loc3_ = _loc8_.orientation.direction.toString();
                  break;
               }
               return false;
            case param1 is EmotePlayMessage:
               _loc9_ = param1 as EmotePlayMessage;
               if(_loc9_.actorId == this._playerId)
               {
                  _loc2_ = "playEmote";
                  _loc3_ = _loc9_.emoteId.toString();
                  break;
               }
               return false;
            case param1 is GameRolePlayShowActorMessage:
               _loc10_ = param1 as GameRolePlayShowActorMessage;
               _loc11_ = EntityLookAdapter.fromNetwork(_loc10_.informations.look);
               if(_loc10_.informations.contextualId == this._playerId && !(_loc11_ as EntityLook == PlayedCharacterManager.getInstance().realEntityLook))
               {
                  _loc4_ = true;
                  _loc2_ = "look";
                  _loc3_ = _loc11_.toString();
                  break;
               }
               return false;
            case param1 is InteractiveUsedMessage:
               _loc12_ = param1 as InteractiveUsedMessage;
               if(_loc12_.entityId == this._playerId)
               {
                  if(!this._waitStartTime)
                  {
                     this._waitStartTime = this._mainSeqStartTime;
                  }
                  _loc16_ = getTimer();
                  _loc17_ = _loc16_ - this._mainSeqStartTime;
                  _loc18_ = _loc16_ - this._waitStartTime;
                  _loc19_ = this._autoTimer;
                  this._autoTimer = false;
                  _loc20_ = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
                  _loc21_ = DofusEntities.getEntity(_loc12_.entityId);
                  _loc22_ = Skill.getSkillById(_loc12_.skillId).useAnimation;
                  _loc23_ = Atouin.getInstance().getIdentifiedElementPosition(_loc12_.elemId);
                  _loc24_ = _loc20_.getUseDirection(_loc21_ as TiphonSprite,_loc22_,_loc23_);
                  this.createLine("player","wait",_loc18_.toString(),false);
                  this.createLine("player","setDirection",_loc24_.toString(),_loc4_);
                  this.createLine("player","setAnimation","\"" + _loc22_ + "\", 5",false);
                  this.addScriptLine("local harvestedRes" + resourceID + " = EntityApi.getWorldEntity(" + _loc12_.elemId + ")");
                  this.addScriptLine("local seqRes" + resourceID + " = SeqApi.create()");
                  this.addScriptLine("seqRes" + resourceID + ".add(harvestedRes" + resourceID + ".wait(" + _loc17_.toString() + "))");
                  this.addScriptLine("seqRes" + resourceID + ".add(harvestedRes" + resourceID + ".setAnimation(\"AnimState2\", 5, \"AnimState2_to_AnimState1\"))");
                  this.addScriptLine("seqRes" + resourceID + ".add(harvestedRes" + resourceID + ".wait(500))");
                  this.addScriptLine("seqRes" + resourceID + ".add(harvestedRes" + resourceID + ".setAnimation(\"AnimState1\", -1, \"none\"))");
                  this._waitStartTime = getTimer();
                  resourceID++;
                  this._elementID = _loc12_.elemId;
                  this._autoTimer = _loc19_;
               }
               return false;
            case param1 is InteractiveUseEndedMessage:
               _loc13_ = param1 as InteractiveUseEndedMessage;
               if(this._elementID == _loc13_.elemId)
               {
                  this._waitStartTime = getTimer();
                  this._elementID = 0;
               }
               return false;
            case param1 is ChatSmileyMessage:
               _loc14_ = param1 as ChatSmileyMessage;
               if(_loc14_.entityId == this._playerId)
               {
                  _loc2_ = "playSmiley";
                  _loc3_ = _loc14_.smileyId.toString();
                  break;
               }
               return false;
            case param1 is CellOverMessage:
               _loc15_ = param1 as CellOverMessage;
               this._currentCell = _loc15_.cell;
               return false;
            case param1 is MouseWheelMessage:
            default:
               return false;
         }
         this.createLine("player",_loc2_,_loc3_,_loc4_);
         return false;
      }
      
      public function cameraZoom(param1:Number, param2:Boolean=false) : void {
         var _loc4_:String = null;
         var _loc3_:SystemApi = new SystemApi();
         if(param1 <= 0 || param1 > AtouinConstants.MAX_ZOOM)
         {
            return;
         }
         if(this._currentCameraZoom != param1)
         {
            this.addScriptLine("seq.add(CameraApi.setZoom(" + param1 + "))");
         }
         this._currentCameraZoom = param1;
         if(this._currentCameraZoom == 1)
         {
            this.addScriptLine("seq.add(CameraApi.zoom(0))");
            return;
         }
         if(param2)
         {
            _loc4_ = "player";
         }
         else
         {
            _loc4_ = this._currentCell.x.toString() + ", " + this._currentCell.y.toString();
         }
         this.addScriptLine("seq.add(CameraApi.zoom(" + _loc4_ + "))");
      }
      
      public function createLine(param1:String, param2:String, param3:String, param4:Boolean) : void {
         if(param4)
         {
            this.addScriptLine("seq.add(" + param1 + "." + param2 + "(\"" + param3 + "\"))");
         }
         else
         {
            this.addScriptLine("seq.add(" + param1 + "." + param2 + "(" + param3 + "))");
         }
      }
      
      public function stop() : void {
         this._autoTimer = false;
         this._running = false;
         this.addSeqStart();
      }
      
      public function addSeqStart() : void {
         var _loc1_:Boolean = this._autoTimer;
         this._autoTimer = false;
         this.addScriptLine("seq.start()",true);
         var _loc2_:* = 0;
         while(_loc2_ < resourceID)
         {
            this.addScriptLine("seqRes" + _loc2_ + ".start()",true);
            _loc2_++;
         }
         this._autoTimer = _loc1_;
      }
      
      public function start(param1:Boolean) : void {
         this._luaScript = "";
         this._running = true;
         this._paused = false;
         this._moveType = LuaMoveEnum.MOVE_DEFAULT;
         this._playerId = PlayedCharacterManager.getInstance().id;
         var _loc2_:IEntity = EntitiesManager.getInstance().getEntity(this._playerId);
         this._playerX = _loc2_.position.x;
         this._playerY = _loc2_.position.y;
         this.addScriptLine("local player = EntityApi.getPlayer()");
         this.addScriptLine("local seq = SeqApi.create()");
         this.createLine("player","teleport",this._playerX.toString() + ", " + this._playerY.toString(),false);
         this._autoTimer = param1;
         this._mainSeqStartTime = getTimer();
         this._waitStartTime = 0;
         this._charMoveStartTime = 0;
         resourceID = 0;
      }
      
      public function set pause(param1:Boolean) : void {
         this._paused = param1;
         if(this._paused == false)
         {
            this._waitStartTime = getTimer();
         }
      }
      
      public function wait(param1:Number) : void {
         this.createLine("player","wait",param1.toString(),false);
      }
      
      public function autoFollowCam(param1:Boolean) : void {
         if(param1)
         {
            this.addScriptLine("seq.add(CameraApi.follow(player))");
         }
         else
         {
            this.addScriptLine("seq.add(CameraApi.stop())");
         }
      }
      
      public function get running() : Boolean {
         return this._running;
      }
      
      public function set moveType(param1:int) : void {
         this._moveType = param1;
      }
      
      public function get luaScript() : String {
         return this._luaScript;
      }
      
      public function get priority() : int {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function set luaScript(param1:String) : void {
         this._luaScript = param1;
      }
   }
}
