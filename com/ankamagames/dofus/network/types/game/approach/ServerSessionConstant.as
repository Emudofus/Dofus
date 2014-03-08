package com.ankamagames.dofus.network.types.game.approach
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ServerSessionConstant extends Object implements INetworkType
   {
      
      public function ServerSessionConstant() {
         super();
      }
      
      public static const protocolId:uint = 430;
      
      public var id:uint = 0;
      
      public function getTypeId() : uint {
         return 430;
      }
      
      public function initServerSessionConstant(id:uint=0) : ServerSessionConstant {
         this.id = id;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ServerSessionConstant(output);
      }
      
      public function serializeAs_ServerSessionConstant(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeShort(this.id);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerSessionConstant(input);
      }
      
      public function deserializeAs_ServerSessionConstant(input:IDataInput) : void {
         this.id = input.readShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ServerSessionConstant.id.");
         }
         else
         {
            return;
         }
      }
   }
}
