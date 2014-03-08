package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AlignmentFrame;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentRankJntGift;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentGift;
   
   public class GiftItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function GiftItemCriterion(param1:String) {
         super(param1);
         var _loc2_:Array = String(_criterionValueText).split(",");
         if((_loc2_) && _loc2_.length > 0)
         {
            if(_loc2_.length <= 2)
            {
               this._aliGiftId = uint(_loc2_[0]);
               this._aliGiftLevel = int(_loc2_[1]);
            }
         }
         else
         {
            this._aliGiftId = uint(_criterionValue);
            this._aliGiftLevel = -1;
         }
      }
      
      private var _aliGiftId:uint;
      
      private var _aliGiftLevel:int = -1;
      
      override public function get isRespected() : Boolean {
         var _loc3_:* = 0;
         var _loc1_:int = (Kernel.getWorker().getFrame(AlignmentFrame) as AlignmentFrame).playerRank;
         var _loc2_:AlignmentRankJntGift = AlignmentRankJntGift.getAlignmentRankJntGiftById(_loc1_);
         if((_loc2_) && (_loc2_.gifts))
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.gifts.length)
            {
               if(_loc2_.gifts[_loc3_] == this._aliGiftId)
               {
                  if(this._aliGiftLevel != 0)
                  {
                     if(_loc2_.levels[_loc3_] > this._aliGiftLevel)
                     {
                        return true;
                     }
                     return false;
                  }
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      override public function get text() : String {
         var _loc1_:Array = null;
         if(_operator.text == ">")
         {
            _loc1_ = _criterionValueText.split(",");
            return I18n.getUiText("ui.pvp.giftRequired",[AlignmentGift.getAlignmentGiftById(this._aliGiftId).name + " > " + this._aliGiftLevel]);
         }
         return I18n.getUiText("ui.pvp.giftRequired",[AlignmentGift.getAlignmentGiftById(this._aliGiftId).name]);
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:GiftItemCriterion = new GiftItemCriterion(this.basicText);
         return _loc1_;
      }
   }
}
