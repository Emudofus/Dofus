package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayMerchantInformations extends GameRolePlayNamedActorInformations implements INetworkType
   {
      
      public function GameRolePlayMerchantInformations() {
         this.options = new Vector.<HumanOption>();
         super();
      }
      
      public static const protocolId:uint = 129;
      
      public var sellType:uint = 0;
      
      public var options:Vector.<HumanOption>;
      
      override public function getTypeId() : uint {
         return 129;
      }
      
      public function initGameRolePlayMerchantInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:String="", param5:uint=0, param6:Vector.<HumanOption>=null) : GameRolePlayMerchantInformations {
         super.initGameRolePlayNamedActorInformations(param1,param2,param3,param4);
         this.sellType = param5;
         this.options = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.sellType = 0;
         this.options = new Vector.<HumanOption>();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayMerchantInformations(param1);
      }
      
      public function serializeAs_GameRolePlayMerchantInformations(param1:IDataOutput) : void {
         super.serializeAs_GameRolePlayNamedActorInformations(param1);
         if(this.sellType < 0)
         {
            throw new Error("Forbidden value (" + this.sellType + ") on element sellType.");
         }
         else
         {
            param1.writeInt(this.sellType);
            param1.writeShort(this.options.length);
            _loc2_ = 0;
            while(_loc2_ < this.options.length)
            {
               param1.writeShort((this.options[_loc2_] as HumanOption).getTypeId());
               (this.options[_loc2_] as HumanOption).serialize(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayMerchantInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayMerchantInformations(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:HumanOption = null;
         super.deserialize(param1);
         this.sellType = param1.readInt();
         if(this.sellType < 0)
         {
            throw new Error("Forbidden value (" + this.sellType + ") on element of GameRolePlayMerchantInformations.sellType.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUnsignedShort();
               _loc5_ = ProtocolTypeManager.getInstance(HumanOption,_loc4_);
               _loc5_.deserialize(param1);
               this.options.push(_loc5_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
