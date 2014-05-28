package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.utils.Dictionary;
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
      
      private static const _log:Logger;
      
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
         var shortcutsFrame:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         this._roleplayWorldFrame = Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame;
         if((!this._roleplayWorldFrame) || (this.triggeredByShortcut) && (shortcutsFrame.heldShortcuts.indexOf("showMonstersInfo") == -1))
         {
            return false;
         }
         this._roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if((this._roleplayEntitiesFrame) && (this._roleplayEntitiesFrame.monstersIds.length > 0))
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
         var monsterId:* = undefined;
         for(monsterId in this._tooltipsCacheNames)
         {
            delete this._tooltipsCacheNames[monsterId];
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
         var shortcutsFrame:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         var shortcutIndex:int = shortcutsFrame.heldShortcuts.indexOf("showMonstersInfo");
         if(shortcutIndex != -1)
         {
            shortcutsFrame.heldShortcuts.splice(shortcutIndex,1);
         }
         KernelEventsManager.getInstance().processCallback(HookList.ShowMonstersInfo,false);
         return true;
      }
      
      public function process(pMsg:Message) : Boolean {
         var ac:AnimatedCharacter = null;
         var emovm:EntityMouseOverMessage = null;
         var emoum:EntityMouseOutMessage = null;
         var gcrem:GameContextRemoveElementMessage = null;
         var emsm:EntityMovementStartMessage = null;
         var emcm:EntityMovementCompleteMessage = null;
         var rootEntity:AnimatedCharacter = null;
         var groupIndex:* = 0;
         if(!Kernel.getWorker().contains(RoleplayWorldFrame))
         {
            return false;
         }
         switch(true)
         {
            case pMsg is EntityMouseOverMessage:
               emovm = pMsg as EntityMouseOverMessage;
               ac = emovm.entity as AnimatedCharacter;
               if(ac)
               {
                  this.updateMouseOverMonstersIds(ac.id);
                  rootEntity = ac.getRootEntity();
                  if(this._tooltipsCacheNames[rootEntity.id])
                  {
                     TooltipManager.hide("MonstersInfo_" + rootEntity.id);
                  }
               }
               break;
            case pMsg is EntityMouseOutMessage:
               emoum = pMsg as EntityMouseOutMessage;
               ac = emoum.entity as AnimatedCharacter;
               if(ac)
               {
                  if(ac.id == this._mouseOverMonsterId)
                  {
                     this._mouseOverMonsterId = 0;
                     this._mouseOverRootMonsterId = 0;
                  }
                  ac = ac.getRootEntity();
                  if(this._tooltipsCacheNames[ac.id])
                  {
                     this.showToolTip(ac.id);
                  }
               }
               break;
            case pMsg is GameContextRemoveElementMessage:
               gcrem = pMsg as GameContextRemoveElementMessage;
               delete this._tooltipsCacheNames[gcrem.id];
               TooltipManager.hide("MonstersInfo_" + gcrem.id);
               break;
            case pMsg is EntityMovementStartMessage:
               emsm = pMsg as EntityMovementStartMessage;
               ac = EntitiesManager.getInstance().getEntity(emsm.id) as AnimatedCharacter;
               if(ac == ac.getRootEntity())
               {
                  if((this._tooltipsCacheNames[ac.id]) && (this._movingGroups.indexOf(ac.id) == -1))
                  {
                     this._movingGroups.push(ac.id);
                  }
               }
               break;
            case pMsg is EntityMovementCompleteMessage:
               emcm = pMsg as EntityMovementCompleteMessage;
               ac = EntitiesManager.getInstance().getEntity(emcm.id) as AnimatedCharacter;
               if(ac == ac.getRootEntity())
               {
                  groupIndex = this._movingGroups.indexOf(ac.id);
                  if((this._tooltipsCacheNames[ac.id]) && (!(groupIndex == -1)))
                  {
                     this._movingGroups.splice(groupIndex,1);
                  }
               }
               if(this._roleplayEntitiesFrame.monstersIds.indexOf(emcm.id) != -1)
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
      
      public function update(pForceRefresh:Boolean = false) : void {
         var i:* = 0;
         var monsterId:* = 0;
         var len:int = this._roleplayEntitiesFrame.monstersIds.length;
         this.updateMouseOverMonstersIds(this._roleplayWorldFrame.mouseOverEntityId);
         this.displayMouseOverEntityTooltip(false);
         i = 0;
         while(i < len)
         {
            monsterId = this._roleplayEntitiesFrame.monstersIds[i];
            if((pForceRefresh) || (!TooltipManager.isVisible("MonstersInfo_" + monsterId)))
            {
               TooltipPlacer.waitBeforeOrder("tooltip_MonstersInfo_" + monsterId);
            }
            i++;
         }
         i = 0;
         while(i < len)
         {
            monsterId = this._roleplayEntitiesFrame.monstersIds[i];
            if((pForceRefresh) || (!TooltipManager.isVisible("MonstersInfo_" + monsterId)))
            {
               this.showToolTip(monsterId,"MonstersInfoCache" + i);
            }
            i++;
         }
      }
      
      public function getCacheName(pEntityId:int) : String {
         return this._tooltipsCacheNames[pEntityId];
      }
      
      private function onLoadUi(pEvent:UiRenderEvent) : void {
         if(!Atouin.getInstance().worldIsVisible)
         {
            EnterFrameDispatcher.removeEventListener(this.updateTooltipPos);
            this._checkMovingGroups = false;
         }
      }
      
      private function onUnLoadUi(pEvent:UiUnloadEvent) : void {
         if(pEvent.name.indexOf("tooltip") == -1)
         {
            this.update();
            if(!this._checkMovingGroups)
            {
               this._checkMovingGroups = true;
               EnterFrameDispatcher.addEventListener(this.updateTooltipPos,"MonstersInfo",StageShareManager.stage.frameRate);
            }
         }
      }
      
      private function onEntityAnimationRendered(pEvent:TiphonEvent) : void {
         var ac:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimationRendered);
         this.showToolTip(ac.id,this._tooltipsCacheNames[ac.id]);
      }
      
      private function updateMouseOverMonstersIds(pEntityId:int) : void {
         var rootEntityId:* = 0;
         var entity:AnimatedCharacter = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
         if(entity)
         {
            rootEntityId = entity.getRootEntity().id;
            if(this._roleplayEntitiesFrame.getEntityInfos(rootEntityId) is GameRolePlayGroupMonsterInformations)
            {
               this._mouseOverMonsterId = pEntityId;
               this._mouseOverRootMonsterId = rootEntityId;
            }
         }
         else
         {
            this._mouseOverMonsterId = this._mouseOverRootMonsterId = 0;
         }
      }
      
      private function displayMouseOverEntityTooltip(pDisplay:Boolean) : void {
         var entity:IInteractive = DofusEntities.getEntity(this._mouseOverMonsterId) as IInteractive;
         if(entity)
         {
            if(pDisplay)
            {
               this._roleplayWorldFrame.process(new EntityMouseOverMessage(entity,true));
            }
            else if(TooltipManager.isVisible("entity_" + this._mouseOverMonsterId))
            {
               this._roleplayWorldFrame.process(new EntityMouseOutMessage(entity));
            }
            
         }
      }
      
      private function updateTooltipPos(pEvent:Event) : void {
         var monsterId:* = 0;
         if(this._movingGroups.length > 0)
         {
            for each(monsterId in this._movingGroups)
            {
               if(monsterId == this._mouseOverRootMonsterId)
               {
                  this.displayMouseOverEntityTooltip(false);
                  this._mouseOverMonsterId = 0;
                  this._mouseOverRootMonsterId = 0;
               }
               this.showToolTip(monsterId);
            }
         }
      }
      
      private function removeTooltips(pDeleteCache:Boolean = true) : void {
         var monsterId:* = 0;
         if((this._roleplayEntitiesFrame) && (this._roleplayEntitiesFrame.monstersIds.length > 0))
         {
            for each(monsterId in this._roleplayEntitiesFrame.monstersIds)
            {
               if(pDeleteCache)
               {
                  delete this._tooltipsCacheNames[monsterId];
               }
               TooltipManager.hide("MonstersInfo_" + monsterId);
               TooltipManager.hide("tooltipOverEntity_" + monsterId);
            }
         }
      }
      
      private function showToolTip(pMonsterId:int, pCacheName:String = null) : void {
         var offset:* = 0;
         var ac:AnimatedCharacter = null;
         var data:GameRolePlayGroupMonsterInformations = null;
         var entity:AnimatedCharacter = DofusEntities.getEntity(pMonsterId) as AnimatedCharacter;
         if(entity)
         {
            TooltipManager.hide("entity_" + pMonsterId);
            if((entity.isMoving) && (this._movingGroups.indexOf(entity.id) == -1))
            {
               this._movingGroups.push(entity.id);
            }
            if(pCacheName)
            {
               this._tooltipsCacheNames[entity.id] = pCacheName;
            }
            offset = this._roleplayEntitiesFrame.hasIcon(entity.id)?45:0;
            ac = entity as AnimatedCharacter;
            data = this._roleplayEntitiesFrame.getEntityInfos(entity.id) as GameRolePlayGroupMonsterInformations;
            if(!ac.rawAnimation)
            {
               ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimationRendered);
            }
            else if(data)
            {
               TooltipManager.show(data,entity.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"MonstersInfo_" + entity.id,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,offset,true,null,null,null,this._tooltipsCacheNames[entity.id],false,StrataEnum.STRATA_WORLD,this._sysApi.getCurrentZoom());
            }
            
         }
      }
   }
}
