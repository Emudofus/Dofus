package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
   
   public class DofusShopArticle extends DofusShopObject implements IDataCenter
   {
      
      public function DofusShopArticle(data:Object) {
         super(data);
      }
      
      private static const date_regexp:RegExp;
      
      private var _subtitle:String;
      
      private var _price:Number;
      
      private var _originalPrice:Number;
      
      private var _endDate:Date;
      
      private var _currency:String;
      
      private var _stock:int;
      
      private var _imgSmall:String;
      
      private var _imgNormal:String;
      
      private var _references:Array;
      
      private var _promo:Array;
      
      private var _endTimer:Timer;
      
      override public function init(data:Object) : void {
         var dateStr:String = null;
         var expirationTime:* = NaN;
         var currentTime:* = NaN;
         var remainingTime:* = NaN;
         super.init(data);
         trace("Adding article with id",id);
         this._subtitle = data.subtitle;
         this._price = data.price;
         this._originalPrice = data.original_price;
         if(data.enddate)
         {
            dateStr = data.enddate;
            dateStr = dateStr.replace(date_regexp,"/");
            this._endDate = new Date(Date.parse(dateStr));
            expirationTime = this._endDate.getTime();
            currentTime = new Date().getTime();
            remainingTime = expirationTime - currentTime;
            if(remainingTime <= 86400000)
            {
               trace("LESS THAN 24H REMAINING!!!");
               this._endTimer = new Timer(remainingTime,1);
               this._endTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
               this._endTimer.start();
            }
         }
         this._currency = data.currency;
         this._stock = data.stock == null?-1:data.stock;
         if(data.image)
         {
            this._imgSmall = data.image["70_70"];
            this._imgNormal = data.image["200_200"];
         }
         this._references = data.references;
         this._promo = data.promo;
      }
      
      protected function onEndDate(event:TimerEvent) : void {
         this._endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
         DofusShopManager.getInstance().updateAfterExpiredArticle(id);
      }
      
      override public function free() : void {
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
         super.free();
      }
      
      public function get subtitle() : String {
         return this._subtitle;
      }
      
      public function get price() : Number {
         return this._price;
      }
      
      public function get originalPrice() : Number {
         return this._originalPrice;
      }
      
      public function get endDate() : Date {
         return this._endDate;
      }
      
      public function get currency() : String {
         return this._currency;
      }
      
      public function get stock() : int {
         return this._stock;
      }
      
      public function get imageSmall() : String {
         return this._imgSmall;
      }
      
      public function get imageNormal() : String {
         return this._imgNormal;
      }
      
      public function get references() : Array {
         return this._references;
      }
      
      public function get promo() : Array {
         return this._promo;
      }
   }
}
