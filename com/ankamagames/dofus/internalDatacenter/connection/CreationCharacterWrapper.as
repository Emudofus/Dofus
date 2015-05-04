package com.ankamagames.dofus.internalDatacenter.connection
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class CreationCharacterWrapper extends Object implements IDataCenter
   {
      
      public function CreationCharacterWrapper()
      {
         this.colors = new Vector.<int>();
         super();
      }
      
      public static function create(param1:String, param2:Boolean, param3:uint, param4:int, param5:Vector.<int>, param6:EntityLook = null) : CreationCharacterWrapper
      {
         var _loc7_:CreationCharacterWrapper = new CreationCharacterWrapper();
         _loc7_.name = param1;
         _loc7_.gender = param2;
         _loc7_.breed = param3;
         _loc7_.cosmeticId = param4;
         _loc7_.colors = param5;
         if(param6)
         {
            _loc7_.entityLook = EntityLookAdapter.fromNetwork(param6);
         }
         return _loc7_;
      }
      
      public var name:String = "";
      
      public var gender:Boolean = false;
      
      public var breed:int = 0;
      
      public var cosmeticId:uint = 0;
      
      public var colors:Vector.<int>;
      
      public var entityLook:TiphonEntityLook;
      
      public function toString() : String
      {
         return "[CreationCharacterWrapper#" + this.name + "_" + this.gender + "_" + this.breed + "_" + this.cosmeticId + "_" + this.colors + "_" + this.entityLook + "]";
      }
   }
}
