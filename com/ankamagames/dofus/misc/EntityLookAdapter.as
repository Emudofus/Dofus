package com.ankamagames.dofus.misc
{
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.look.SubEntity;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   
   public class EntityLookAdapter extends Object
   {
      
      public function EntityLookAdapter() {
         super();
      }
      
      public static function fromNetwork(param1:EntityLook) : TiphonEntityLook {
         var _loc3_:uint = 0;
         var _loc5_:SubEntity = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:TiphonEntityLook = new TiphonEntityLook();
         _loc2_.lock();
         _loc2_.setBone(param1.bonesId);
         for each (_loc3_ in param1.skins)
         {
            _loc2_.addSkin(_loc3_);
         }
         if(param1.bonesId == 1 || param1.bonesId == 2)
         {
            _loc2_.defaultSkin = 1965;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param1.indexedColors.length)
         {
            _loc6_ = param1.indexedColors[_loc4_] >> 24 & 255;
            _loc7_ = param1.indexedColors[_loc4_] & 16777215;
            _loc2_.setColor(_loc6_,_loc7_);
            _loc4_++;
         }
         if(param1.scales.length == 1)
         {
            _loc2_.setScales(param1.scales[0] / 100,param1.scales[0] / 100);
         }
         else
         {
            if(param1.scales.length == 2)
            {
               _loc2_.setScales(param1.scales[0] / 100,param1.scales[1] / 100);
            }
         }
         for each (_loc5_ in param1.subentities)
         {
            _loc2_.addSubEntity(_loc5_.bindingPointCategory,_loc5_.bindingPointIndex,EntityLookAdapter.fromNetwork(_loc5_.subEntityLook));
         }
         _loc2_.unlock(true);
         return _loc2_;
      }
      
      public static function toNetwork(param1:TiphonEntityLook) : EntityLook {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:uint = 0;
         var _loc13_:SubEntity = null;
         var _loc2_:EntityLook = new EntityLook();
         _loc2_.bonesId = param1.getBone();
         _loc2_.skins = param1.getSkins(false,false);
         var _loc3_:Array = param1.getColors(true);
         for (_loc4_ in _loc3_)
         {
            _loc7_ = parseInt(_loc4_);
            _loc8_ = _loc3_[_loc4_];
            _loc9_ = (_loc7_ & 255) << 24 | _loc8_ & 16777215;
            _loc2_.indexedColors.push(_loc9_);
         }
         _loc2_.scales.push(uint(param1.getScaleX() * 100));
         _loc2_.scales.push(uint(param1.getScaleY() * 100));
         _loc5_ = param1.getSubEntities(true);
         for (_loc6_ in _loc5_)
         {
            _loc10_ = parseInt(_loc6_);
            for (_loc11_ in _loc5_[_loc6_])
            {
               _loc12_ = parseInt(_loc11_);
               _loc13_ = new SubEntity();
               _loc13_.initSubEntity(_loc10_,_loc12_,EntityLookAdapter.toNetwork(_loc5_[_loc6_][_loc11_]));
               _loc2_.subentities.push(_loc13_);
            }
         }
         return _loc2_;
      }
      
      public static function tiphonizeLook(param1:*) : TiphonEntityLook {
         var _loc2_:TiphonEntityLook = null;
         var param1:* = SecureCenter.unsecure(param1);
         if(param1 is TiphonEntityLook)
         {
            _loc2_ = param1 as TiphonEntityLook;
         }
         if(param1 is EntityLook)
         {
            _loc2_ = fromNetwork(param1);
         }
         if(param1 is String)
         {
            _loc2_ = TiphonEntityLook.fromString(param1);
         }
         return _loc2_;
      }
      
      public static function getRiderLook(param1:*) : TiphonEntityLook {
         var param1:* = SecureCenter.unsecure(param1);
         var _loc2_:TiphonEntityLook = tiphonizeLook(param1);
         var _loc3_:TiphonEntityLook = _loc2_.clone();
         var _loc4_:TiphonEntityLook = _loc3_.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(_loc4_)
         {
            if(_loc4_.getBone() == 2)
            {
               _loc4_.setBone(1);
            }
            _loc3_ = _loc4_;
         }
         return _loc3_;
      }
   }
}
