package com.ankamagames.dofus.internalDatacenter.connection
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   
   public class BasicCharacterWrapper extends Object implements IDataCenter
   {
      
      public function BasicCharacterWrapper() {
         super();
      }
      
      public static function create(param1:uint, param2:String, param3:uint, param4:EntityLook, param5:uint, param6:Boolean, param7:uint=0, param8:uint=0, param9:uint=0, param10:Boolean=false) : BasicCharacterWrapper {
         var _loc11_:BasicCharacterWrapper = new BasicCharacterWrapper();
         _loc11_.id = param1;
         _loc11_.name = param2;
         _loc11_.level = param3;
         _loc11_.entityLook = EntityLookAdapter.fromNetwork(param4);
         _loc11_.breedId = param5;
         _loc11_.sex = param6;
         _loc11_.deathState = param7;
         _loc11_.deathCount = param8;
         _loc11_.bonusXp = param9;
         _loc11_.unusable = param10;
         return _loc11_;
      }
      
      public var id:uint;
      
      public var name:String;
      
      public var level:uint;
      
      public var entityLook:TiphonEntityLook;
      
      public var breedId:uint;
      
      public var sex:Boolean;
      
      public var deathState:uint;
      
      public var deathCount:uint;
      
      public var bonusXp:uint;
      
      public var unusable:Boolean;
      
      private var _breed:Breed;
      
      public function get breed() : Breed {
         if(!this._breed)
         {
            this._breed = Breed.getBreedById(this.breedId);
         }
         return this._breed;
      }
      
      public function toString() : String {
         return "[BasicCharacterWrapper#" + this.id + "_" + this.name + "]";
      }
   }
}
