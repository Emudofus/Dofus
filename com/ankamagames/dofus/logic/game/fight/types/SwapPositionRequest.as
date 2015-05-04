package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import flash.filters.GlowFilter;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import flash.geom.Point;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.berilia.managers.TooltipManager;
   
   public class SwapPositionRequest extends Object
   {
      
      public function SwapPositionRequest(param1:uint, param2:int, param3:int)
      {
         super();
         this.requestId = param1;
         this.requesterId = param2;
         this.requestedId = param3;
         this._instanceName = "swapPositionRequest#" + param1;
         this._timelineInstanceName = "timeline_" + this._instanceName;
      }
      
      private var _instanceName:String;
      
      private var _icon:UiRootContainer;
      
      private var _timelineInstanceName:String;
      
      private var _timelineIcon:UiRootContainer;
      
      private var _isRequesterIcon:Boolean;
      
      public var requestId:uint;
      
      public var requesterId:int;
      
      public var requestedId:int;
      
      public function set visible(param1:Boolean) : void
      {
         this._timelineIcon.visible = param1;
      }
      
      public function destroy() : void
      {
         Berilia.getInstance().unloadUi(this._instanceName);
         Berilia.getInstance().unloadUi(this._timelineInstanceName);
         var _loc1_:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(_loc1_)
         {
            _loc1_.removeSwapPositionRequest(this.requestId);
         }
      }
      
      public function showRequesterIcon() : void
      {
         this._isRequesterIcon = true;
         this.showIcon();
      }
      
      public function showRequestedIcon() : void
      {
         this._isRequesterIcon = false;
         this.showIcon();
      }
      
      public function updateIcon() : void
      {
         var _loc1_:AnimatedCharacter = DofusEntities.getEntity(this._isRequesterIcon?this.requesterId:this.requestedId) as AnimatedCharacter;
         if(this._icon.scale != Atouin.getInstance().currentZoom)
         {
            this._icon.scale = Atouin.getInstance().currentZoom;
         }
         this.placeIcon(_loc1_);
         this.placeTimelineIcon(_loc1_);
      }
      
      private function showIcon() : void
      {
         var _loc1_:int = this._isRequesterIcon?this.requesterId:this.requestedId;
         var _loc2_:UiModule = UiModuleManager.getInstance().getModule("Ankama_Fight");
         var _loc3_:AnimatedCharacter = DofusEntities.getEntity(_loc1_) as AnimatedCharacter;
         this._icon = Berilia.getInstance().loadUi(_loc2_,_loc2_.uis["swapPositionIcon"],this._instanceName,{
            "requestId":this.requestId,
            "isRequester":this._isRequesterIcon,
            "entityId":_loc1_,
            "rollEvents":false
         },false);
         this._icon.filters = [new GlowFilter(0,1,2,2,2,1)];
         this.placeIcon(_loc3_);
         this._timelineIcon = Berilia.getInstance().loadUi(_loc2_,_loc2_.uis["swapPositionIcon"],this._timelineInstanceName,{
            "requestId":this.requestId,
            "isRequester":this._isRequesterIcon,
            "entityId":_loc1_,
            "rollEvents":true
         },false);
         this.placeTimelineIcon(_loc3_);
      }
      
      private function placeIcon(param1:AnimatedCharacter) : void
      {
         var _loc3_:IRectangle = null;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle2 = null;
         var _loc8_:* = NaN;
         var _loc9_:Point = null;
         var _loc2_:TiphonSprite = param1 as TiphonSprite;
         if((_loc2_.getSubEntitySlot(2,0)) && !EntitiesLooksManager.getInstance().isCreatureMode())
         {
            _loc2_ = _loc2_.getSubEntitySlot(2,0) as TiphonSprite;
         }
         var _loc6_:DisplayObject = _loc2_.getSlot("Tete");
         var _loc7_:DisplayObject = _loc2_.getBackground("readySwords");
         if((_loc6_) && !_loc7_)
         {
            _loc4_ = _loc6_.getBounds(StageShareManager.stage);
            _loc5_ = new Rectangle2(_loc4_.x,_loc4_.y,_loc4_.width,_loc4_.height);
            _loc3_ = _loc5_;
         }
         else if(!_loc7_)
         {
            _loc3_ = (_loc2_ as IDisplayable).absoluteBounds;
         }
         else
         {
            _loc4_ = _loc7_.getBounds(StageShareManager.stage);
            _loc5_ = new Rectangle2(_loc4_.x,_loc4_.y,_loc4_.width,_loc4_.height);
            _loc3_ = _loc5_;
         }
         
         if(_loc3_)
         {
            _loc8_ = TooltipManager.isVisible("tooltipOverEntity_" + param1.id)?70:10;
            _loc9_ = new Point(_loc3_.x + _loc3_.width / 2,_loc3_.y - _loc8_);
            this._icon.x = _loc9_.x;
            this._icon.y = _loc9_.y;
         }
      }
      
      private function placeTimelineIcon(param1:AnimatedCharacter) : void
      {
         var _loc2_:UiRootContainer = Berilia.getInstance().getUi("timeline");
         var _loc3_:Object = _loc2_.uiClass.getFighterById(param1.id).frame;
         var _loc4_:Point = _loc3_.getParent().localToGlobal(new Point(_loc3_.x,_loc3_.y));
         this._timelineIcon.x = _loc4_.x + 20;
         this._timelineIcon.y = _loc4_.y - 6;
      }
   }
}
