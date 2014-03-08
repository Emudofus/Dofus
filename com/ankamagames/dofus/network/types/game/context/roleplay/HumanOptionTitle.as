package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOptionTitle extends HumanOption implements INetworkType
   {
      
      public function HumanOptionTitle() {
         super();
      }
      
      public static const protocolId:uint = 408;
      
      public var titleId:uint = 0;
      
      public var titleParam:String = "";
      
      override public function getTypeId() : uint {
         return 408;
      }
      
      public function initHumanOptionTitle(param1:uint=0, param2:String="") : HumanOptionTitle {
         this.titleId = param1;
         this.titleParam = param2;
         return this;
      }
      
      override public function reset() : void {
         this.titleId = 0;
         this.titleParam = "";
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HumanOptionTitle(param1);
      }
      
      public function serializeAs_HumanOptionTitle(param1:IDataOutput) : void {
         super.serializeAs_HumanOption(param1);
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
         }
         else
         {
            param1.writeShort(this.titleId);
            param1.writeUTF(this.titleParam);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HumanOptionTitle(param1);
      }
      
      public function deserializeAs_HumanOptionTitle(param1:IDataInput) : void {
         super.deserialize(param1);
         this.titleId = param1.readShort();
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element of HumanOptionTitle.titleId.");
         }
         else
         {
            this.titleParam = param1.readUTF();
            return;
         }
      }
   }
}
