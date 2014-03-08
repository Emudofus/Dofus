package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class Inventory extends Object
   {
      
      public function Inventory() {
         this._itemsDict = new Dictionary();
         this._hookLock = new HookLock();
         super();
         this._views = new Dictionary();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Inventory));
      
      public static const HIDDEN_TYPE_ID:uint = 118;
      
      public static const PETSMOUNT_TYPE_ID:uint = 121;
      
      public static const COMPANION_TYPE_ID:uint = 169;
      
      private var _itemsDict:Dictionary;
      
      private var _views:Dictionary;
      
      private var _hookLock:HookLock;
      
      private var _kamas:int;
      
      private var _hiddedKamas:int;
      
      public function get hookLock() : HookLock {
         return this._hookLock;
      }
      
      public function get localKamas() : int {
         return this._kamas;
      }
      
      public function get kamas() : int {
         return this._kamas;
      }
      
      public function set kamas(param1:int) : void {
         this._kamas = param1;
         StorageOptionManager.getInstance().updateStorageView();
      }
      
      public function set hiddedKamas(param1:int) : void {
         StorageOptionManager.getInstance().updateStorageView();
      }
      
      public function addView(param1:IInventoryView) : void {
         this._views[param1.name] = param1;
      }
      
      public function getView(param1:String) : IInventoryView {
         return this._views[param1];
      }
      
      public function removeView(param1:String) : void {
         var _loc2_:IInventoryView = this.getView(param1);
         if(_loc2_)
         {
            delete this._views[[param1]];
         }
      }
      
      public function getItem(param1:int) : ItemWrapper {
         if(this._itemsDict[param1])
         {
            return (this._itemsDict[param1] as ItemSet).item;
         }
         return null;
      }
      
      public function getItemMaskCount(param1:int, param2:String) : int {
         var _loc3_:ItemSet = this._itemsDict[param1];
         if(!_loc3_)
         {
            _log.error("Suppression d\'un item qui n\'existe pas");
            return 0;
         }
         if(_loc3_.masks.hasOwnProperty(param2))
         {
            return _loc3_.masks[param2];
         }
         return 0;
      }
      
      public function initialize(param1:Vector.<ItemWrapper>) : void {
         var _loc2_:ItemWrapper = null;
         var _loc3_:ItemSet = null;
         this._itemsDict = new Dictionary();
         for each (_loc2_ in param1)
         {
            _loc3_ = new ItemSet();
            _loc3_.item = _loc2_;
            _loc3_.masks = new Dictionary();
            this._itemsDict[_loc2_.objectUID] = _loc3_;
         }
         this.initializeViews(param1);
      }
      
      public function initializeFromObjectItems(param1:Vector.<ObjectItem>) : void {
         var _loc3_:ObjectItem = null;
         var _loc4_:ItemWrapper = null;
         var _loc5_:ItemSet = null;
         var _loc2_:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         this._itemsDict = new Dictionary();
         for each (_loc3_ in param1)
         {
            _loc4_ = ItemWrapper.create(_loc3_.position,_loc3_.objectUID,_loc3_.objectGID,_loc3_.quantity,_loc3_.effects);
            _loc5_ = new ItemSet();
            _loc5_.item = _loc4_;
            _loc5_.masks = new Dictionary();
            this._itemsDict[_loc3_.objectUID] = _loc5_;
            _loc2_.push(_loc4_);
         }
         this.initializeViews(_loc2_);
      }
      
      public function addObjectItem(param1:ObjectItem) : void {
         var _loc2_:ItemWrapper = ItemWrapper.create(param1.position,param1.objectUID,param1.objectGID,param1.quantity,param1.effects,false);
         this.addItem(_loc2_);
      }
      
      public function addItem(param1:ItemWrapper) : void {
         var _loc3_:ItemWrapper = null;
         var _loc2_:ItemSet = this._itemsDict[param1.objectUID];
         if(_loc2_)
         {
            _loc3_ = param1.clone();
            _loc2_.item.quantity = _loc2_.item.quantity + param1.quantity;
            _loc2_.masks = new Dictionary();
            this.modifyItemFromViews(_loc2_,_loc3_);
         }
         else
         {
            _loc2_ = new ItemSet();
            _loc2_.item = param1;
            _loc2_.masks = new Dictionary();
            this._itemsDict[param1.objectUID] = _loc2_;
            this.addItemToViews(_loc2_);
         }
      }
      
      public function removeItem(param1:int, param2:int=-1) : void {
         var _loc4_:ItemWrapper = null;
         var _loc3_:ItemSet = this._itemsDict[param1];
         if(!_loc3_)
         {
            _log.error("Suppression d\'un item qui n\'existe pas");
            return;
         }
         if(param2 == -1 || param2 == _loc3_.item.quantity)
         {
            delete this._itemsDict[[param1]];
            this.removeItemFromViews(_loc3_);
         }
         else
         {
            if(_loc3_.item.quantity < param2)
            {
               _log.error("On essaye de supprimer de l\'inventaire plus d\'objet qu\'il n\'en existe");
               return;
            }
            _loc4_ = _loc3_.item.clone();
            _loc3_.item.quantity = _loc3_.item.quantity - param2;
            this.modifyItemFromViews(_loc3_,_loc4_);
         }
      }
      
      public function modifyItemQuantity(param1:int, param2:int) : void {
         var _loc3_:ItemSet = this._itemsDict[param1];
         if(!_loc3_)
         {
            _log.error("On essaye de modifier la quantité d\'un objet qui n\'existe pas");
            return;
         }
         var _loc4_:ItemWrapper = _loc3_.item.clone();
         _loc4_.quantity = param2;
         this.modifyItem(_loc4_);
      }
      
      public function modifyItemPosition(param1:int, param2:int) : void {
         var _loc3_:ItemSet = this._itemsDict[param1];
         if(!_loc3_)
         {
            _log.error("On essaye de modifier la position d\'un objet qui n\'existe pas");
            return;
         }
         var _loc4_:ItemWrapper = _loc3_.item.clone();
         _loc4_.position = param2;
         if(_loc4_.typeId == PETSMOUNT_TYPE_ID)
         {
            if(param2 == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS)
            {
               PlayedCharacterManager.getInstance().isPetsMounting = true;
            }
            else
            {
               PlayedCharacterManager.getInstance().isPetsMounting = false;
            }
         }
         else
         {
            if(_loc4_.typeId == COMPANION_TYPE_ID)
            {
               if(param2 == CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION)
               {
                  PlayedCharacterManager.getInstance().hasCompanion = true;
               }
               else
               {
                  PlayedCharacterManager.getInstance().hasCompanion = false;
               }
            }
         }
         this.modifyItem(_loc4_);
      }
      
      public function modifyObjectItem(param1:ObjectItem) : void {
         var _loc2_:ItemWrapper = ItemWrapper.create(param1.position,param1.objectUID,param1.objectGID,param1.quantity,param1.effects,false);
         this.modifyItem(_loc2_);
      }
      
      public function modifyItem(param1:ItemWrapper) : void {
         var _loc3_:ItemWrapper = null;
         var _loc2_:ItemSet = this._itemsDict[param1.objectUID];
         if(_loc2_)
         {
            _loc3_ = _loc2_.item.clone();
            this.copyItem(_loc2_.item,param1);
            this.modifyItemFromViews(_loc2_,_loc3_);
         }
         else
         {
            this.addItem(param1);
         }
      }
      
      public function addItemMask(param1:int, param2:String, param3:int) : void {
         var _loc4_:ItemSet = this._itemsDict[param1];
         if(!_loc4_)
         {
            _log.error("On essaye de masquer un item qui n\'existe pas dans l\'inventaire");
            return;
         }
         _loc4_.masks[param2] = param3;
         this.modifyItemFromViews(_loc4_,_loc4_.item);
      }
      
      public function removeItemMask(param1:int, param2:String) : void {
         var _loc3_:ItemSet = this._itemsDict[param1];
         if(!_loc3_)
         {
            _log.error("On essaye de retirer le masque d\'un item qui n\'existe pas dans l\'inventaire");
            return;
         }
         delete _loc3_.masks[[param2]];
         this.modifyItemFromViews(_loc3_,_loc3_.item);
      }
      
      public function removeAllItemMasks(param1:String) : void {
         var _loc2_:ItemSet = null;
         for each (_loc2_ in this._itemsDict)
         {
            if(_loc2_.masks[param1])
            {
               delete _loc2_.masks[[param1]];
               this.modifyItemFromViews(_loc2_,_loc2_.item);
            }
         }
      }
      
      public function removeAllItemsMasks() : void {
         var _loc1_:ItemSet = null;
         for each (_loc1_ in this._itemsDict)
         {
            if(_loc1_.masks.length > 0)
            {
               _loc1_.masks = new Dictionary();
               this.modifyItemFromViews(_loc1_,_loc1_.item);
            }
         }
      }
      
      public function releaseHooks() : void {
         this._hookLock.release();
      }
      
      public function refillView(param1:String, param2:String) : void {
         var _loc3_:IInventoryView = this.getView(param1);
         var _loc4_:IInventoryView = this.getView(param2);
         if(!_loc3_ || !_loc4_)
         {
            return;
         }
         _loc4_.initialize(_loc3_.content);
      }
      
      protected function addItemToViews(param1:ItemSet) : void {
         var _loc2_:IInventoryView = null;
         for each (_loc2_ in this._views)
         {
            if(_loc2_.isListening(param1.item))
            {
               _loc2_.addItem(param1.item,0);
            }
         }
      }
      
      protected function modifyItemFromViews(param1:ItemSet, param2:ItemWrapper) : void {
         var _loc4_:* = 0;
         var _loc5_:IInventoryView = null;
         var _loc3_:* = 0;
         for each (_loc4_ in param1.masks)
         {
            _loc3_ = _loc3_ + _loc4_;
         }
         for each (_loc5_ in this._views)
         {
            if(_loc5_.isListening(param1.item))
            {
               if(_loc5_.isListening(param2))
               {
                  _loc5_.modifyItem(param1.item,param2,_loc3_);
               }
               else
               {
                  _loc5_.addItem(param1.item,_loc3_);
               }
            }
            else
            {
               if(_loc5_.isListening(param2))
               {
                  _loc5_.removeItem(param2,_loc3_);
               }
            }
         }
      }
      
      protected function removeItemFromViews(param1:ItemSet) : void {
         var _loc2_:IInventoryView = null;
         for each (_loc2_ in this._views)
         {
            if(_loc2_.isListening(param1.item))
            {
               _loc2_.removeItem(param1.item,0);
            }
         }
      }
      
      protected function initializeViews(param1:Vector.<ItemWrapper>) : void {
         var _loc2_:IInventoryView = null;
         for each (_loc2_ in this._views)
         {
            _loc2_.initialize(param1);
         }
      }
      
      protected function copyItem(param1:ItemWrapper, param2:ItemWrapper) : void {
         param1.update(param2.position,param2.objectUID,param2.objectGID,param2.quantity,param2.effectsList);
      }
   }
}
import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
import flash.utils.Dictionary;

class ItemSet extends Object
{
   
   function ItemSet() {
      super();
   }
   
   public var item:ItemWrapper;
   
   public var masks:Dictionary;
}
