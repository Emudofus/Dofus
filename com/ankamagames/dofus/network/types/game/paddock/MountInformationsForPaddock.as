package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class MountInformationsForPaddock extends Object implements INetworkType
   {
      
      public function MountInformationsForPaddock() {
         super();
      }
      
      public static const protocolId:uint = 184;
      
      public var modelId:int = 0;
      
      public var name:String = "";
      
      public var ownerName:String = "";
      
      public function getTypeId() : uint {
         return 184;
      }
      
      public function initMountInformationsForPaddock(modelId:int=0, name:String="", ownerName:String="") : MountInformationsForPaddock {
         this.modelId = modelId;
         this.name = name;
         this.ownerName = ownerName;
         return this;
      }
      
      public function reset() : void {
         this.modelId = 0;
         this.name = "";
         this.ownerName = "";
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MountInformationsForPaddock(output);
      }
      
      public function serializeAs_MountInformationsForPaddock(output:IDataOutput) : void {
         output.writeInt(this.modelId);
         output.writeUTF(this.name);
         output.writeUTF(this.ownerName);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountInformationsForPaddock(input);
      }
      
      public function deserializeAs_MountInformationsForPaddock(input:IDataInput) : void {
         this.modelId = input.readInt();
         this.name = input.readUTF();
         this.ownerName = input.readUTF();
      }
   }
}
