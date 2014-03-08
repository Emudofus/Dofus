package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOptionFollowers extends HumanOption implements INetworkType
   {
      
      public function HumanOptionFollowers() {
         this.followingCharactersLook = new Vector.<IndexedEntityLook>();
         super();
      }
      
      public static const protocolId:uint = 410;
      
      public var followingCharactersLook:Vector.<IndexedEntityLook>;
      
      override public function getTypeId() : uint {
         return 410;
      }
      
      public function initHumanOptionFollowers(param1:Vector.<IndexedEntityLook>=null) : HumanOptionFollowers {
         this.followingCharactersLook = param1;
         return this;
      }
      
      override public function reset() : void {
         this.followingCharactersLook = new Vector.<IndexedEntityLook>();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HumanOptionFollowers(param1);
      }
      
      public function serializeAs_HumanOptionFollowers(param1:IDataOutput) : void {
         super.serializeAs_HumanOption(param1);
         param1.writeShort(this.followingCharactersLook.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.followingCharactersLook.length)
         {
            (this.followingCharactersLook[_loc2_] as IndexedEntityLook).serializeAs_IndexedEntityLook(param1);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HumanOptionFollowers(param1);
      }
      
      public function deserializeAs_HumanOptionFollowers(param1:IDataInput) : void {
         var _loc4_:IndexedEntityLook = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new IndexedEntityLook();
            _loc4_.deserialize(param1);
            this.followingCharactersLook.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
