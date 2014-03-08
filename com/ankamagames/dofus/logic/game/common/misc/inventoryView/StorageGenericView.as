package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.logic.game.common.misc.Inventory;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
   
   public class StorageGenericView extends Object implements IStorageView
   {
      
      public function StorageGenericView(param1:HookLock) {
         this._typesQty = new Dictionary();
         this._types = new Dictionary();
         super();
         this._hookLock = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageView));
      
      protected var _content:Vector.<ItemWrapper>;
      
      protected var _sortedContent:Vector.<ItemWrapper>;
      
      protected var _hookLock:HookLock;
      
      protected var _sorted:Boolean = false;
      
      private var _sortFieldsCache:Array;
      
      private var _sortRevertCache:Boolean;
      
      protected var _typesQty:Dictionary;
      
      protected var _types:Dictionary;
      
      public function initialize(param1:Vector.<ItemWrapper>) : void {
         var _loc2_:ItemWrapper = null;
         if(!this._content)
         {
            this._content = new Vector.<ItemWrapper>();
         }
         else
         {
            this._content.length = 0;
         }
         this._typesQty = new Dictionary();
         this._types = new Dictionary();
         this._sortedContent = null;
         for each (_loc2_ in param1)
         {
            if(this.isListening(_loc2_))
            {
               this.addItem(_loc2_,0);
            }
         }
         this._content.sort(this.sortItemsByIndex);
         this.updateView();
      }
      
      public function get name() : String {
         throw new Error("StorageGenericView class must be extended");
      }
      
      public function get content() : Vector.<ItemWrapper> {
         if(this._sorted)
         {
            return this._sortedContent;
         }
         return this._content;
      }
      
      public function get types() : Dictionary {
         return this._types;
      }
      
      public function addItem(param1:ItemWrapper, param2:int) : void {
         var _loc3_:ItemWrapper = param1.clone();
         _loc3_.quantity = _loc3_.quantity - param2;
         this._content.unshift(_loc3_);
         if(this._sortedContent)
         {
            this._sortedContent.unshift(_loc3_);
         }
         if((this._typesQty[param1.typeId]) && this._typesQty[param1.typeId] > 0)
         {
            this._typesQty[param1.typeId]++;
         }
         else
         {
            this._typesQty[param1.typeId] = 1;
            this._types[param1.typeId] = param1.type;
         }
         this.updateView();
      }
      
      public function removeItem(param1:ItemWrapper, param2:int) : void {
         var _loc3_:int = this.getItemIndex(param1);
         if(_loc3_ == -1)
         {
            return;
         }
         if((this._typesQty[param1.typeId]) && this._typesQty[param1.typeId] > 0)
         {
            this._typesQty[param1.typeId]--;
            if(this._typesQty[param1.typeId] == 0)
            {
               delete this._types[[param1.typeId]];
            }
         }
         this._content.splice(_loc3_,1);
         if(this._sortedContent)
         {
            _loc3_ = this.getItemIndex(param1,this._sortedContent);
            if(_loc3_ != -1)
            {
               this._sortedContent.splice(_loc3_,1);
            }
         }
         this.updateView();
      }
      
      public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void {
         var _loc5_:ItemWrapper = null;
         var _loc4_:int = this.getItemIndex(param1);
         if(_loc4_ != -1)
         {
            _loc5_ = this._content[_loc4_];
            if(_loc5_.quantity == param1.quantity - param3)
            {
               _loc5_.update(param1.position,param1.objectUID,param1.objectGID,_loc5_.quantity,param1.effectsList);
               this.updateView();
            }
            else
            {
               if(param1.quantity <= param3)
               {
                  this.removeItem(_loc5_,param3);
               }
               else
               {
                  _loc5_.update(param1.position,param1.objectUID,param1.objectGID,param1.quantity - param3,param1.effectsList);
                  this.updateView();
               }
            }
         }
         else
         {
            if(param3 < param1.quantity)
            {
               this.addItem(param1,param3);
            }
         }
      }
      
      public function isListening(param1:ItemWrapper) : Boolean {
         return param1.position == 63 && !(Item.getItemById(param1.objectGID).typeId == Inventory.HIDDEN_TYPE_ID);
      }
      
      public function getItemTypes() : Dictionary {
         return this._types;
      }
      
      protected function getItemIndex(param1:ItemWrapper, param2:Vector.<ItemWrapper>=null) : int {
         var _loc4_:ItemWrapper = null;
         if(param2 == null)
         {
            param2 = this._content;
         }
         var _loc3_:* = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_ = param2[_loc3_];
            if(_loc4_.objectUID == param1.objectUID)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function sortItemsByIndex(param1:ItemWrapper, param2:ItemWrapper) : int {
         if(param1.sortOrder > param2.sortOrder)
         {
            return -1;
         }
         if(param1.sortOrder == param2.sortOrder)
         {
            return 0;
         }
         return 1;
      }
      
      private function compareFunction(param1:ItemWrapper, param2:ItemWrapper, param3:uint=0) : int {
         var _loc4_:* = 0;
         switch(this._sortFieldsCache[param3])
         {
            case StorageOptionManager.SORT_FIELD_NAME:
               if(!this._sortRevertCache)
               {
                  _loc4_ = param1.name > param2.name?1:param1.name < param2.name?-1:0;
               }
               else
               {
                  _loc4_ = param1.name < param2.name?1:param1.name > param2.name?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_WEIGHT:
               if(!this._sortRevertCache)
               {
                  _loc4_ = param1.weight < param2.weight?1:param1.weight > param2.weight?-1:0;
               }
               else
               {
                  _loc4_ = param1.weight > param2.weight?1:param1.weight < param2.weight?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_LOT_WEIGHT:
               if(!this._sortRevertCache)
               {
                  _loc4_ = param1.weight * param1.quantity < param2.weight * param2.quantity?1:param1.weight * param1.quantity > param2.weight * param2.quantity?-1:0;
               }
               else
               {
                  _loc4_ = param1.weight * param1.quantity > param2.weight * param2.quantity?1:param1.weight * param1.quantity < param2.weight * param2.quantity?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_QUANTITY:
               if(!this._sortRevertCache)
               {
                  _loc4_ = param1.quantity < param2.quantity?1:param1.quantity > param2.quantity?-1:0;
               }
               else
               {
                  _loc4_ = param1.quantity > param2.quantity?1:param1.quantity < param2.quantity?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_DEFAULT:
               if(!this._sortRevertCache)
               {
                  _loc4_ = param1.objectUID < param2.objectUID?1:param1.objectUID > param2.objectUID?-1:0;
               }
               else
               {
                  _loc4_ = param1.objectUID > param2.objectUID?1:param1.objectUID < param2.objectUID?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_AVERAGEPRICE:
               if(!this._sortRevertCache)
               {
                  _loc4_ = this.getItemAveragePrice(param1.objectGID) < this.getItemAveragePrice(param2.objectGID)?1:this.getItemAveragePrice(param1.objectGID) > this.getItemAveragePrice(param2.objectGID)?-1:0;
               }
               else
               {
                  _loc4_ = this.getItemAveragePrice(param1.objectGID) > this.getItemAveragePrice(param2.objectGID)?1:this.getItemAveragePrice(param1.objectGID) < this.getItemAveragePrice(param2.objectGID)?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_LOT_AVERAGEPRICE:
               if(!this._sortRevertCache)
               {
                  _loc4_ = this.getItemAveragePrice(param1.objectGID) * param1.quantity < this.getItemAveragePrice(param2.objectGID) * param2.quantity?1:this.getItemAveragePrice(param1.objectGID) * param1.quantity > this.getItemAveragePrice(param2.objectGID) * param2.quantity?-1:0;
               }
               else
               {
                  _loc4_ = this.getItemAveragePrice(param1.objectGID) * param1.quantity > this.getItemAveragePrice(param2.objectGID) * param2.quantity?1:this.getItemAveragePrice(param1.objectGID) * param1.quantity < this.getItemAveragePrice(param2.objectGID) * param2.quantity?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_LEVEL:
               if(!this._sortRevertCache)
               {
                  _loc4_ = param1.level < param2.level?1:param1.level > param2.level?-1:0;
               }
               else
               {
                  _loc4_ = param1.level > param2.level?1:param1.level < param2.level?-1:0;
               }
               break;
            case StorageOptionManager.SORT_FIELD_ITEM_TYPE:
               if(!this._sortRevertCache)
               {
                  _loc4_ = param1.type.name > param2.type.name?1:param1.type.name < param2.type.name?-1:0;
               }
               else
               {
                  _loc4_ = param1.type.name < param2.type.name?1:param1.type.name > param2.type.name?-1:0;
               }
               break;
            default:
               _loc4_ = 0;
         }
         if(_loc4_ != 0)
         {
            return _loc4_;
         }
         if(param3 == this._sortFieldsCache.length-1)
         {
            return 0;
         }
         return this.compareFunction(param1,param2,++param3);
      }
      
      private function getItemAveragePrice(param1:uint) : int {
         var _loc2_:AveragePricesFrame = Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame;
         return _loc2_.pricesData.items["item" + param1];
      }
      
      public function updateView() : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:ItemWrapper = null;
         var _loc1_:* = true;
         if((this._sortFieldsCache) && this._sortFieldsCache.length == this.sortFields().length)
         {
            _loc3_ = this._sortFieldsCache.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(this._sortFieldsCache[_loc2_] != this.sortFields()[_loc2_])
               {
                  _loc1_ = false;
                  break;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc1_ = false;
         }
         this._sortFieldsCache = this.sortFields();
         if(this._sortFieldsCache[0] != StorageOptionManager.SORT_FIELD_NONE)
         {
            if(!_loc1_)
            {
               this._sortRevertCache = this.sortRevert();
            }
            else
            {
               if(StorageOptionManager.getInstance().newSort)
               {
                  this._sortRevertCache = !this._sortRevertCache;
               }
            }
            if(!this._sortedContent)
            {
               this._sortedContent = new Vector.<ItemWrapper>();
               for each (_loc4_ in this._content)
               {
                  this._sortedContent.push(_loc4_);
               }
            }
            this._sortedContent.sort(this.compareFunction);
            this._sorted = true;
         }
         else
         {
            this._sorted = false;
         }
      }
      
      public function sortFields() : Array {
         return StorageOptionManager.getInstance().sortFields;
      }
      
      public function sortRevert() : Boolean {
         return StorageOptionManager.getInstance().sortRevert;
      }
      
      public function empty() : void {
         this._content = new Vector.<ItemWrapper>();
         this._sortedContent = null;
         this.updateView();
      }
   }
}
