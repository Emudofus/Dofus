package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.Timer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
   
   public class DofusShopArticle extends DofusShopObject implements IDataCenter
   {
      
      public function DofusShopArticle(param1:Object)
      {
         super(param1);
      }
      
      private static const date_regexp:RegExp = new RegExp(new RegExp("\\-","g"));
      
      private var _subtitle:String;
      
      private var _price:Number;
      
      private var _originalPrice:Number;
      
      private var _endDate:Date;
      
      private var _currency:String;
      
      private var _stock:int;
      
      private var _imgSmall:String;
      
      private var _imgNormal:String;
      
      private var _imgSwf:Uri;
      
      private var _references:Array;
      
      private var _promo:Array;
      
      private var _endTimer:Timer;
      
      private var _gids:Array;
      
      private var _isNew:Boolean;
      
      private var _hasExpired:Boolean;
      
      override public function init(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:Object = null;
         var _loc7_:Date = null;
         var _loc8_:Object = null;
         var _loc9_:ItemWrapper = null;
         super.init(param1);
         this._subtitle = param1.subtitle;
         this._price = param1.price;
         this._originalPrice = param1.original_price;
         this._isNew = false;
         var _loc2_:Number = new Date().getTime();
         if(param1.startdate)
         {
            _loc3_ = param1.startdate;
            _loc3_ = _loc3_.replace(date_regexp,"/");
            _loc7_ = new Date(Date.parse(_loc3_));
            _loc4_ = _loc7_.getTime();
            _loc5_ = _loc2_ - _loc4_;
            this._isNew = _loc5_ > 0 && _loc5_ < 864000000;
         }
         if(param1.enddate)
         {
            _loc3_ = param1.enddate;
            _loc3_ = _loc3_.replace(date_regexp,"/");
            this._endDate = new Date(Date.parse(_loc3_));
            _loc4_ = this._endDate.getTime();
            _loc5_ = _loc4_ - _loc2_;
            if(_loc5_ <= 0)
            {
               this._hasExpired = true;
            }
            else if(_loc5_ <= 43200000)
            {
               this._endTimer = new Timer(_loc5_,1);
               this._endTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
               this._endTimer.start();
            }
            
         }
         this._currency = param1.currency;
         this._stock = param1.stock == null?-1:param1.stock;
         this._references = param1.references;
         this._gids = [];
         for each(_loc6_ in this._references)
         {
            if((_loc6_) && (typeof _loc6_ == "object") && (_loc6_.hasOwnProperty("content")))
            {
               for each(_loc8_ in _loc6_.content)
               {
                  if((_loc8_) && (typeof _loc8_ == "object") && (_loc8_.hasOwnProperty("id")))
                  {
                     this._gids.push(parseInt(_loc8_.id));
                  }
               }
            }
         }
         if(this._gids.length == 1)
         {
            _loc9_ = ItemWrapper.create(0,0,this._gids[0],1,null,false);
            this._imgSwf = _loc9_.getIconUri(false);
         }
         if(param1.image)
         {
            this._imgSmall = param1.image["70_70"];
            this._imgNormal = param1.image["200_200"];
         }
         this._promo = param1.promo;
      }
      
      protected function onEndDate(param1:TimerEvent) : void
      {
         this._endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
         DofusShopManager.getInstance().updateAfterExpiredArticle(id);
      }
      
      override public function free() : void
      {
         if(this._endTimer)
         {
            this._endTimer.stop();
            this._endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
            this._endTimer = null;
         }
         this._subtitle = null;
         this._price = 0;
         this._originalPrice = 0;
         this._endDate = null;
         this._currency = null;
         this._stock = 0;
         this._imgSmall = null;
         this._imgNormal = null;
         this._references = null;
         this._promo = null;
         this._gids = null;
         super.free();
      }
      
      public function get subtitle() : String
      {
         return this._subtitle;
      }
      
      public function get price() : Number
      {
         return this._price;
      }
      
      public function get originalPrice() : Number
      {
         return this._originalPrice;
      }
      
      public function get endDate() : Date
      {
         return this._endDate;
      }
      
      public function get currency() : String
      {
         return this._currency;
      }
      
      public function get stock() : int
      {
         return this._stock;
      }
      
      public function get imageSmall() : String
      {
         return this._imgSmall;
      }
      
      public function get imageSwf() : Uri
      {
         return this._imgSwf;
      }
      
      public function get imageNormal() : String
      {
         return this._imgNormal;
      }
      
      public function get references() : Array
      {
         return this._references;
      }
      
      public function get gids() : Array
      {
         return this._gids;
      }
      
      public function get promo() : Array
      {
         return this._promo;
      }
      
      public function get isNew() : Boolean
      {
         return this._isNew;
      }
      
      public function get hasExpired() : Boolean
      {
         return this._hasExpired;
      }
   }
}
