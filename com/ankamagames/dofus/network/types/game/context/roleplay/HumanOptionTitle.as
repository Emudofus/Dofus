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
      
      public function initHumanOptionTitle(titleId:uint = 0, titleParam:String = "") : HumanOptionTitle {
         this.titleId = titleId;
         this.titleParam = titleParam;
         return this;
      }
      
      override public function reset() : void {
         this.titleId = 0;
         this.titleParam = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_HumanOptionTitle(output);
      }
      
      public function serializeAs_HumanOptionTitle(output:IDataOutput) : void {
         super.serializeAs_HumanOption(output);
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
         }
         else
         {
            output.writeShort(this.titleId);
            output.writeUTF(this.titleParam);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HumanOptionTitle(input);
      }
      
      public function deserializeAs_HumanOptionTitle(input:IDataInput) : void {
         super.deserialize(input);
         this.titleId = input.readShort();
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element of HumanOptionTitle.titleId.");
         }
         else
         {
            this.titleParam = input.readUTF();
            return;
         }
      }
   }
}
