package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
   import com.ankamagames.atouin.messages.EntityMovementStartMessage;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import flash.events.Event;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class MonstersInfoFrame extends Object implements Frame
   {
      
      public function MonstersInfoFrame() {
         this._sysApi = new SystemApi();
         this._tooltipsCacheNames = new Dictionary();
         this._movingGroups = new Vector.<int>();
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(MonstersInfoFrame));
      
      private var _sysApi:SystemApi;
      
      private var _roleplayEntitiesFrame:RoleplayEntitiesFrame;
      
      private var _roleplayWorldFrame:RoleplayWorldFrame;
      
      private var _tooltipsCacheNames:Dictionary;
      
      private var _movingGroups:Vector.<int>;
      
      private var _checkMovingGroups:Boolean;
      
      private var _mouseOverMonsterId:int;
      
      private var _mouseOverRootMonsterId:int;
      
      public var triggeredByShortcut:Boolean;
      
      public function pushed() : Boolean {
         var _loc1_:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         this._roleplayWorldFrame = Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame;
         if(!this._roleplayWorldFrame || (this.triggeredByShortcut) && _loc1_.heldShortcuts.indexOf("showMonstersInfo") == -1)
         {
            return false;
         }
         this._roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if((this._roleplayEntitiesFrame) && this._roleplayEntitiesFrame.monstersIds.length > 0)
         {
            this.update();
         }
         this._checkMovingGroups = true;
         EnterFrameDispatcher.addEventListener(this.updateTooltipPos,"MonstersInfo",StageShareManager.stage.frameRate);
         Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete,this.onLoadUi);
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUnLoadUi);
         KernelEventsManager.getInstance().processCallback(HookList.ShowMonstersInfo,true);
         return true;
      }
      
      public function pulled() : Boolean {
         var _loc1_:* = undefined;
         for (_loc1_ in this._tooltipsCacheNames)
         {
            delete this._tooltipsCacheNames[[_loc1_]];
         }
         this.removeTooltips();
         this._movingGroups.length = 0;
         EnterFrameDispatcher.removeEventListener(this.updateTooltipPos);
         Berilia.getInstance().removeEventListener(UiRenderEvent.UIRenderComplete,this.onLoadUi);
         Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUnLoadUi);
         this.updateMouseOverMonstersIds(this._roleplayWorldFrame.mouseOverEntityId);
         if(StageShareManager.stage.nativeWindow.active)
         {
            this.displayMouseOverEntityTooltip(true);
         }
         var _loc2_:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         var _loc3_:int = _loc2_.heldShortcuts.indexOf("showMonstersInfo");
         if(_loc3_ != -1)
         {
            _loc2_.heldShortcuts.splice(_loc3_,1);
         }
         KernelEventsManager.getInstance().processCallback(HookList.ShowMonstersInfo,false);
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:AnimatedCharacter = null;
         var _loc3_:EntityMouseOverMessage = null;
         var _loc4_:EntityMouseOutMessage = null;
         var _loc5_:GameContextRemoveElementMessage = null;
         var _loc6_:EntityMovementStartMessage = null;
         var _loc7_:EntityMovementCompleteMessage = null;
         var _loc8_:AnimatedCharacter = null;
         var _loc9_:* = 0;
         if(!Kernel.getWorker().contains(RoleplayWorldFrame))
         {
            return false;
         }
         switch(true)
         {
            case param1 is EntityMouseOverMessage:
               _loc3_ = param1 as EntityMouseOverMessage;
               _loc2_ = _loc3_.entity as AnimatedCharacter;
               if(_loc2_)
               {
                  this.updateMouseOverMonstersIds(_loc2_.id);
                  _loc8_ = _loc2_.getRootEntity();
                  if(this._tooltipsCacheNames[_loc8_.id])
                  {
                     TooltipManager.hide("MonstersInfo_" + _loc8_.id);
                  }
               }
               break;
            case param1 is EntityMouseOutMessage:
               _loc4_ = param1 as EntityMouseOutMessage;
               _loc2_ = _loc4_.entity as AnimatedCharacter;
               if(_loc2_)
               {
                  if(_loc2_.id == this._mouseOverMonsterId)
                  {
                     this._mouseOverMonsterId = 0;
                     this._mouseOverRootMonsterId = 0;
                  }
                  _loc2_ = _loc2_.getRootEntity();
                  if(this._tooltipsCacheNames[_loc2_.id])
                  {
                     this.showToolTip(_loc2_.id);
                  }
               }
               break;
            case param1 is GameContextRemoveElementMessage:
               _loc5_ = param1 as GameContextRemoveElementMessage;
               delete this._tooltipsCacheNames[[_loc5_.id]];
               TooltipManager.hide("MonstersInfo_" + _loc5_.id);
               break;
            case param1 is EntityMovementStartMessage:
               _loc6_ = param1 as EntityMovementStartMessage;
               _loc2_ = EntitiesManager.getInstance().getEntity(_loc6_.id) as AnimatedCharacter;
               if(_loc2_ == _loc2_.getRootEntity())
               {
                  if((this._tooltipsCacheNames[_loc2_.id]) && this._movingGroups.indexOf(_loc2_.id) == -1)
                  {
                     this._movingGroups.push(_loc2_.id);
                  }
               }
               break;
            case param1 is EntityMovementCompleteMessage:
               _loc7_ = param1 as EntityMovementCompleteMessage;
               _loc2_ = EntitiesManager.getInstance().getEntity(_loc7_.id) as AnimatedCharacter;
               if(_loc2_ == _loc2_.getRootEntity())
               {
                  _loc9_ = this._movingGroups.indexOf(_loc2_.id);
                  if((this._tooltipsCacheNames[_loc2_.id]) && !(_loc9_ == -1))
                  {
                     this._movingGroups.splice(_loc9_,1);
                  }
               }
               if(this._roleplayEntitiesFrame.monstersIds.indexOf(_loc7_.id) != -1)
               {
                  this.update(true);
               }
               break;
         }
         return false;
      }
      
      public function get priority() : int {
         return Priority.HIGH;
      }
      
      public function update(param1:Boolean=false) : void {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:int = this._roleplayEntitiesFrame.monstersIds.length;
         this.updateMouseOverMonstersIds(this._roleplayWorldFrame.mouseOverEntityId);
         this.displayMouseOverEntityTooltip(false);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this._roleplayEntitiesFrame.monstersIds[_loc2_];
            if((param1) || !TooltipManager.isVisible("MonstersInfo_" + _loc4_))
            {
               TooltipPlacer.waitBeforeOrder("tooltip_MonstersInfo_" + _loc4_);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this._roleplayEntitiesFrame.monstersIds[_loc2_];
            if((param1) || !TooltipManager.isVisible("MonstersInfo_" + _loc4_))
            {
               this.showToolTip(_loc4_,"MonstersInfoCache" + _loc2_);
            }
            _loc2_++;
         }
      }
      
      public function getCacheName(param1:int) : String {
         return this._tooltipsCacheNames[param1];
      }
      
      private function onLoadUi(param1:UiRenderEvent) : void {
         if(!Atouin.getInstance().worldIsVisible)
         {
            EnterFrameDispatcher.removeEventListener(this.updateTooltipPos);
            this._checkMovingGroups = false;
         }
      }
      
      private function onUnLoadUi(param1:UiUnloadEvent) : void {
         if(param1.name.indexOf("tooltip") == -1)
         {
            this.update();
            if(!this._checkMovingGroups)
            {
               this._checkMovingGroups = true;
               EnterFrameDispatcher.addEventListener(this.updateTooltipPos,"MonstersInfo",StageShareManager.stage.frameRate);
            }
         }
      }
      
      private function onEntityAnimationRendered(param1:TiphonEvent) : void {
         var _loc2_:AnimatedCharacter = param1.currentTarget as AnimatedCharacter;
         _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimationRendered);
         this.showToolTip(_loc2_.id,this._tooltipsCacheNames[_loc2_.id]);
      }
      
      private function updateMouseOverMonstersIds(param1:int) : void {
         var _loc3_:* = 0;
         var _loc2_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         if(_loc2_)
         {
            _loc3_ = _loc2_.getRootEntity().id;
            if(this._roleplayEntitiesFrame.getEntityInfos(_loc3_) is GameRolePlayGroupMonsterInformations)
            {
               this._mouseOverMonsterId = param1;
               this._mouseOverRootMonsterId = _loc3_;
            }
         }
         else
         {
            this._mouseOverMonsterId = this._mouseOverRootMonsterId = 0;
         }
      }
      
      private function displayMouseOverEntityTooltip(param1:Boolean) : void {
         var _loc2_:IInteractive = DofusEntities.getEntity(this._mouseOverMonsterId) as IInteractive;
         if(_loc2_)
         {
            if(param1)
            {
               this._roleplayWorldFrame.process(new EntityMouseOverMessage(_loc2_,true));
            }
            else
            {
               if(TooltipManager.isVisible("entity_" + this._mouseOverMonsterId))
               {
                  this._roleplayWorldFrame.process(new EntityMouseOutMessage(_loc2_));
               }
            }
         }
      }
      
      private function updateTooltipPos(param1:Event) : void {
         var _loc2_:* = 0;
         if(this._movingGroups.length > 0)
         {
            for each (_loc2_ in this._movingGroups)
            {
               if(_loc2_ == this._mouseOverRootMonsterId)
               {
                  this.displayMouseOverEntityTooltip(false);
                  this._mouseOverMonsterId = 0;
                  this._mouseOverRootMonsterId = 0;
               }
               this.showToolTip(_loc2_);
            }
         }
      }
      
      private function removeTooltips(param1:Boolean=true) : void {
         var _loc2_:* = 0;
         if((this._roleplayEntitiesFrame) && this._roleplayEntitiesFrame.monstersIds.length > 0)
         {
            for each (_loc2_ in this._roleplayEntitiesFrame.monstersIds)
            {
               if(param1)
               {
                  delete this._tooltipsCacheNames[[_loc2_]];
               }
               TooltipManager.hide("MonstersInfo_" + _loc2_);
               TooltipManager.hide("tooltipOverEntity_" + _loc2_);
            }
         }
      }
      
      private function showToolTip(param1:int, param2:String=null) : void {
         var _loc4_:* = 0;
         var _loc5_:AnimatedCharacter = null;
         var _loc6_:GameRolePlayGroupMonsterInformations = null;
         var _loc3_:AnimatedCharacter = DofusEntities.getEntity(param1) as AnimatedCharacter;
         if(_loc3_)
         {
            TooltipManager.hide("entity_" + param1);
            if((_loc3_.isMoving) && this._movingGroups.indexOf(_loc3_.id) == -1)
            {
               this._movingGroups.push(_loc3_.id);
            }
            if(param2)
            {
               this._tooltipsCacheNames[_loc3_.id] = param2;
            }
            _loc4_ = this._roleplayEntitiesFrame.hasIcon(_loc3_.id)?45:0;
            _loc5_ = _loc3_ as AnimatedCharacter;
            _loc6_ = this._roleplayEntitiesFrame.getEntityInfos(_loc3_.id) as GameRolePlayGroupMonsterInformations;
            if(!_loc5_.rawAnimation)
            {
               _loc5_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimationRendered);
            }
            else
            {
               if(_loc6_)
               {
                  TooltipManager.show(_loc6_,_loc3_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"MonstersInfo_" + _loc3_.id,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,_loc4_,true,null,null,null,this._tooltipsCacheNames[_loc3_.id],false,StrataEnum.STRATA_WORLD,this._sysApi.getCurrentZoom());
               }
            }
         }
      }
   }
}
