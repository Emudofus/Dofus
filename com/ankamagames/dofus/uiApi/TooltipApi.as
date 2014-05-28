package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.types.tooltip.TooltipBlock;
   import com.ankamagames.berilia.factories.TooltipsFactory;
   import com.ankamagames.jerakine.utils.misc.CheckCompatibility;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.data.ChunkData;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.types.data.SpellTooltipInfo;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.types.data.ItemTooltipInfo;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.berilia.types.tooltip.TooltipRectangle;
   import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   
   public class TooltipApi extends Object implements IApi
   {
      
      public function TooltipApi() {
         this._ttCallbacks = new Dictionary();
         super();
      }
      
      protected static const _log:Logger;
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      private var _ttCallbacks:Dictionary;
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function set currentUi(value:UiRootContainer) : void {
         this._currentUi = value;
      }
      
      public function destroy() : void {
         this._module = null;
         this._currentUi = null;
      }
      
      public function setDefaultTooltipUiScript(module:String, ui:String) : void {
         var m:UiModule = UiModuleManager.getInstance().getModule(module);
         if(!m)
         {
            throw new ApiError("Module " + module + " doesn\'t exist");
         }
         else
         {
            uiData = m.getUi(ui);
            if(!uiData)
            {
               throw new ApiError("UI " + ui + " doesn\'t exist in module " + module);
            }
            else
            {
               TooltipManager.defaultTooltipUiScript = uiData.uiClass;
               return;
            }
         }
      }
      
      public function createTooltip(baseUri:String, containerUri:String, separatorUri:String = null) : Tooltip {
         var t:Tooltip = null;
         if(baseUri.substr(-4,4) != ".txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + baseUri);
         }
         else if(containerUri.substr(-4,4) != ".txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + containerUri);
         }
         else
         {
            if(separatorUri)
            {
               if(separatorUri.substr(-4,4) != ".txt")
               {
                  throw new ApiError("ChunkData support only [.txt] file, found " + separatorUri);
               }
               else
               {
                  t = new Tooltip(new Uri(this._module.rootPath + "/" + baseUri),new Uri(this._module.rootPath + "/" + containerUri),new Uri(this._module.rootPath + "/" + separatorUri));
               }
            }
            else
            {
               t = new Tooltip(new Uri(this._module.rootPath + "/" + baseUri),new Uri(this._module.rootPath + "/" + containerUri));
            }
            return t;
         }
         
      }
      
      public function createTooltipBlock(onAllChunkLoadedCallback:Function, contentGetter:Function) : TooltipBlock {
         var tb:TooltipBlock = new TooltipBlock();
         tb.onAllChunkLoadedCallback = onAllChunkLoadedCallback;
         tb.contentGetter = contentGetter;
         return tb;
      }
      
      public function registerTooltipAssoc(targetClass:*, makerName:String) : void {
         TooltipsFactory.registerAssoc(targetClass,makerName);
      }
      
      public function registerTooltipMaker(makerName:String, makerClass:Class, scriptClass:Class = null) : void {
         if(CheckCompatibility.isCompatible(ITooltipMaker,makerClass))
         {
            TooltipsFactory.registerMaker(makerName,makerClass,scriptClass);
            return;
         }
         throw new ApiError(makerName + " maker class is not compatible with ITooltipMaker");
      }
      
      public function createChunkData(name:String, uri:String) : ChunkData {
         var newUri:Uri = new Uri(this._module.rootPath + "/" + uri);
         if(newUri.fileType.toLowerCase() != "txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + uri);
         }
         else
         {
            return new ChunkData(name,newUri);
         }
      }
      
      public function place(target:*, point:uint = 6, relativePoint:uint = 0, offset:int = 3, checkSuperposition:Boolean = false, cellId:int = -1, alwaysDisplayed:Boolean = true) : void {
         if((target) && (CheckCompatibility.isCompatible(IRectangle,target)))
         {
            if(this._currentUi.ready)
            {
               this.placeTooltip(this._currentUi,target,point,relativePoint,offset,checkSuperposition,cellId,alwaysDisplayed);
            }
            else
            {
               this._currentUi.removeEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
               this._ttCallbacks[this._currentUi] = new Callback(this.placeTooltip,this._currentUi,target,point,relativePoint,offset,checkSuperposition,cellId,alwaysDisplayed);
               this._currentUi.addEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
            }
         }
      }
      
      private function placeTooltip(pTooltipUi:UiRootContainer, pTarget:*, pPoint:uint, pRelativePoint:uint, pOffset:int, pCheckSuperposition:Boolean, pCellId:int, pAlwaysDisplayed:Boolean) : void {
         TooltipPlacer.place(pTooltipUi,pTarget,pPoint,pRelativePoint,pOffset,pAlwaysDisplayed);
         if((pCheckSuperposition) && (!(pCellId == -1)))
         {
            TooltipPlacer.addTooltipPosition(pTooltipUi,pTarget,pCellId);
         }
      }
      
      public function placeArrow(target:*) : Object {
         if((target) && (CheckCompatibility.isCompatible(IRectangle,target)))
         {
            return TooltipPlacer.placeWithArrow(this._currentUi,target);
         }
         return null;
      }
      
      public function getSpellTooltipInfo(spellWrapper:SpellWrapper, shortcutKey:String = null) : Object {
         return new SpellTooltipInfo(spellWrapper,shortcutKey);
      }
      
      public function getItemTooltipInfo(itemWrapper:ItemWrapper, shortcutKey:String = null) : Object {
         return new ItemTooltipInfo(itemWrapper,shortcutKey);
      }
      
      public function getSpellTooltipCache() : int {
         return PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM;
      }
      
      public function resetSpellTooltipCache() : void {
         PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM++;
      }
      
      public function createTooltipRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) : TooltipRectangle {
         return new TooltipRectangle(x,y,width,height);
      }
      
      public function createSpellSettings() : SpellTooltipSettings {
         return new SpellTooltipSettings();
      }
      
      public function createItemSettings() : ItemTooltipSettings {
         return new ItemTooltipSettings();
      }
      
      private function onTooltipReady(pEvent:UiRenderEvent) : void {
         var currentUi:UiRootContainer = pEvent.currentTarget as UiRootContainer;
         currentUi.removeEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
         (this._ttCallbacks[currentUi] as Callback).exec();
         delete this._ttCallbacks[currentUi];
      }
   }
}
