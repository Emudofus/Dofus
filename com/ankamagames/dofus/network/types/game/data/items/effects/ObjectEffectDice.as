package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectDice extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectDice() {
         super();
      }
      
      public static const protocolId:uint = 73;
      
      public var diceNum:uint = 0;
      
      public var diceSide:uint = 0;
      
      public var diceConst:uint = 0;
      
      override public function getTypeId() : uint {
         return 73;
      }
      
      public function initObjectEffectDice(actionId:uint=0, diceNum:uint=0, diceSide:uint=0, diceConst:uint=0) : ObjectEffectDice {
         super.initObjectEffect(actionId);
         this.diceNum = diceNum;
         this.diceSide = diceSide;
         this.diceConst = diceConst;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.diceNum = 0;
         this.diceSide = 0;
         this.diceConst = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectDice(output);
      }
      
      public function serializeAs_ObjectEffectDice(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         if(this.diceNum < 0)
         {
            throw new Error("Forbidden value (" + this.diceNum + ") on element diceNum.");
         }
         else
         {
            output.writeShort(this.diceNum);
            if(this.diceSide < 0)
            {
               throw new Error("Forbidden value (" + this.diceSide + ") on element diceSide.");
            }
            else
            {
               output.writeShort(this.diceSide);
               if(this.diceConst < 0)
               {
                  throw new Error("Forbidden value (" + this.diceConst + ") on element diceConst.");
               }
               else
               {
                  output.writeShort(this.diceConst);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectDice(input);
      }
      
      public function deserializeAs_ObjectEffectDice(input:IDataInput) : void {
         super.deserialize(input);
         this.diceNum = input.readShort();
         if(this.diceNum < 0)
         {
            throw new Error("Forbidden value (" + this.diceNum + ") on element of ObjectEffectDice.diceNum.");
         }
         else
         {
            this.diceSide = input.readShort();
            if(this.diceSide < 0)
            {
               throw new Error("Forbidden value (" + this.diceSide + ") on element of ObjectEffectDice.diceSide.");
            }
            else
            {
               this.diceConst = input.readShort();
               if(this.diceConst < 0)
               {
                  throw new Error("Forbidden value (" + this.diceConst + ") on element of ObjectEffectDice.diceConst.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
