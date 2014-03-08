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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TooltipApi));
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      private var _ttCallbacks:Dictionary;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function set currentUi(param1:UiRootContainer) : void {
         this._currentUi = param1;
      }
      
      public function destroy() : void {
         this._module = null;
         this._currentUi = null;
      }
      
      public function setDefaultTooltipUiScript(param1:String, param2:String) : void {
         var _loc3_:UiModule = UiModuleManager.getInstance().getModule(param1);
         if(!_loc3_)
         {
            throw new ApiError("Module " + param1 + " doesn\'t exist");
         }
         else
         {
            _loc4_ = _loc3_.getUi(param2);
            if(!_loc4_)
            {
               throw new ApiError("UI " + param2 + " doesn\'t exist in module " + param1);
            }
            else
            {
               TooltipManager.defaultTooltipUiScript = _loc4_.uiClass;
               return;
            }
         }
      }
      
      public function createTooltip(param1:String, param2:String, param3:String=null) : Tooltip {
         var _loc4_:Tooltip = null;
         if(param1.substr(-4,4) != ".txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + param1);
         }
         else
         {
            if(param2.substr(-4,4) != ".txt")
            {
               throw new ApiError("ChunkData support only [.txt] file, found " + param2);
            }
            else
            {
               if(param3)
               {
                  if(param3.substr(-4,4) != ".txt")
                  {
                     throw new ApiError("ChunkData support only [.txt] file, found " + param3);
                  }
                  else
                  {
                     _loc4_ = new Tooltip(new Uri(this._module.rootPath + "/" + param1),new Uri(this._module.rootPath + "/" + param2),new Uri(this._module.rootPath + "/" + param3));
                  }
               }
               else
               {
                  _loc4_ = new Tooltip(new Uri(this._module.rootPath + "/" + param1),new Uri(this._module.rootPath + "/" + param2));
               }
               return _loc4_;
            }
         }
      }
      
      public function createTooltipBlock(param1:Function, param2:Function) : TooltipBlock {
         var _loc3_:TooltipBlock = new TooltipBlock();
         _loc3_.onAllChunkLoadedCallback = param1;
         _loc3_.contentGetter = param2;
         return _loc3_;
      }
      
      public function registerTooltipAssoc(param1:*, param2:String) : void {
         TooltipsFactory.registerAssoc(param1,param2);
      }
      
      public function registerTooltipMaker(param1:String, param2:Class, param3:Class=null) : void {
         if(CheckCompatibility.isCompatible(ITooltipMaker,param2))
         {
            TooltipsFactory.registerMaker(param1,param2,param3);
            return;
         }
         throw new ApiError(param1 + " maker class is not compatible with ITooltipMaker");
      }
      
      public function createChunkData(param1:String, param2:String) : ChunkData {
         var _loc3_:Uri = new Uri(this._module.rootPath + "/" + param2);
         if(_loc3_.fileType.toLowerCase() != "txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + param2);
         }
         else
         {
            return new ChunkData(param1,_loc3_);
         }
      }
      
      public function place(param1:*, param2:uint=6, param3:uint=0, param4:int=3, param5:Boolean=false, param6:int=-1, param7:Boolean=true) : void {
         if((param1) && (CheckCompatibility.isCompatible(IRectangle,param1)))
         {
            if(this._currentUi.ready)
            {
               this.placeTooltip(this._currentUi,param1,param2,param3,param4,param5,param6,param7);
            }
            else
            {
               this._currentUi.removeEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
               this._ttCallbacks[this._currentUi] = new Callback(this.placeTooltip,this._currentUi,param1,param2,param3,param4,param5,param6,param7);
               this._currentUi.addEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
            }
         }
      }
      
      private function placeTooltip(param1:UiRootContainer, param2:*, param3:uint, param4:uint, param5:int, param6:Boolean, param7:int, param8:Boolean) : void {
         TooltipPlacer.place(param1,param2,param3,param4,param5,param8);
         if((param6) && !(param7 == -1))
         {
            TooltipPlacer.addTooltipPosition(param1,param2,param7);
         }
      }
      
      public function placeArrow(param1:*) : Object {
         if((param1) && (CheckCompatibility.isCompatible(IRectangle,param1)))
         {
            return TooltipPlacer.placeWithArrow(this._currentUi,param1);
         }
         return null;
      }
      
      public function getSpellTooltipInfo(param1:SpellWrapper, param2:String=null) : Object {
         return new SpellTooltipInfo(param1,param2);
      }
      
      public function getItemTooltipInfo(param1:ItemWrapper, param2:String=null) : Object {
         return new ItemTooltipInfo(param1,param2);
      }
      
      public function getSpellTooltipCache() : int {
         return PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM;
      }
      
      public function resetSpellTooltipCache() : void {
         PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM++;
      }
      
      public function createTooltipRectangle(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0) : TooltipRectangle {
         return new TooltipRectangle(param1,param2,param3,param4);
      }
      
      public function createSpellSettings() : SpellTooltipSettings {
         return new SpellTooltipSettings();
      }
      
      public function createItemSettings() : ItemTooltipSettings {
         return new ItemTooltipSettings();
      }
      
      private function onTooltipReady(param1:UiRenderEvent) : void {
         var _loc2_:UiRootContainer = param1.currentTarget as UiRootContainer;
         _loc2_.removeEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
         (this._ttCallbacks[_loc2_] as Callback).exec();
         delete this._ttCallbacks[[_loc2_]];
      }
   }
}
