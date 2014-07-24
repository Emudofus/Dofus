package ui
{
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2api.JobsApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Texture;
   
   public class InteractiveElementTooltipUi extends Object
   {
      
      public function InteractiveElementTooltipUi() {
         super();
      }
      
      private static const MARGIN:uint = 5;
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      public var jobsApi:JobsApi;
      
      public var ctr_elementName:GraphicContainer;
      
      public var lbl_elementName:Label;
      
      public var lbl_enabledSkills:Label;
      
      public var lbl_disabledSkills:Label;
      
      public var ctr_line:GraphicContainer;
      
      public var main_ctr:GraphicContainer;
      
      public var ctr_stars:GraphicContainer;
      
      public var lbl_resources_qty:Label;
      
      public var star00:Texture;
      
      public var star01:Texture;
      
      public var star02:Texture;
      
      public var star03:Texture;
      
      public var star04:Texture;
      
      public var star10:Texture;
      
      public var star11:Texture;
      
      public var star12:Texture;
      
      public var star13:Texture;
      
      public var star14:Texture;
      
      public var star20:Texture;
      
      public var star21:Texture;
      
      public var star22:Texture;
      
      public var star23:Texture;
      
      public var star24:Texture;
      
      public function main(oParam:Object = null) : void {
         var ageBonus:* = 0;
         var starBonus:* = 0;
         var color:* = 0;
         var numStars:* = 0;
         var i:* = 0;
         var disabledSkillsY:* = NaN;
         var collectInfos:Object = null;
         var minResources:* = 0;
         var maxResources:* = 0;
         var qty:* = 0;
         var bonus:* = NaN;
         var data:Object = oParam.data;
         this.main_ctr.width = 0;
         this.ctr_line.width = 0;
         this.ctr_elementName.width = 1;
         this.lbl_resources_qty.width = 1;
         this.ctr_line.removeFromParent();
         this.ctr_elementName.removeFromParent();
         this.lbl_disabledSkills.removeFromParent();
         this.lbl_enabledSkills.removeFromParent();
         this.ctr_stars.removeFromParent();
         this.lbl_resources_qty.removeFromParent();
         this.lbl_elementName.text = data.interactive;
         this.lbl_elementName.x = 0;
         this.ctr_elementName.x = 5;
         this.lbl_elementName.fullWidth();
         this.main_ctr.addContent(this.ctr_line);
         this.ctr_line.y = this.lbl_elementName.y + this.lbl_elementName.contentHeight;
         if(data.enabledSkills != "")
         {
            this.lbl_enabledSkills.visible = true;
            this.lbl_enabledSkills.y = this.lbl_elementName.y + this.lbl_elementName.contentHeight + MARGIN;
            this.lbl_enabledSkills.text = data.enabledSkills.substr(0,data.enabledSkills.lastIndexOf("\n"));
            this.lbl_disabledSkills.y = this.lbl_enabledSkills.y + this.lbl_enabledSkills.contentHeight;
         }
         else
         {
            this.lbl_enabledSkills.visible = false;
            this.lbl_disabledSkills.y = this.lbl_elementName.y + this.lbl_elementName.contentHeight + MARGIN;
         }
         this.lbl_disabledSkills.text = data.disabledSkills.substr(0,data.disabledSkills.lastIndexOf("\n"));
         this.lbl_disabledSkills.x = 5;
         this.lbl_enabledSkills.x = 5;
         this.main_ctr.addContent(this.lbl_disabledSkills);
         if(data.enabledSkills != "")
         {
            this.main_ctr.addContent(this.lbl_enabledSkills);
         }
         var maxWidth:Number = this.main_ctr.contentWidth;
         if(data.isCollectable)
         {
            if(data.hasOwnProperty("ageBonus"))
            {
               starBonus = ageBonus = data.ageBonus;
               this.ctr_stars.y = this.ctr_line.y;
               this.star00.visible = false;
               this.star01.visible = false;
               this.star02.visible = false;
               this.star03.visible = false;
               this.star04.visible = false;
               this.star10.visible = false;
               this.star11.visible = false;
               this.star12.visible = false;
               this.star13.visible = false;
               this.star14.visible = false;
               this.star20.visible = false;
               this.star21.visible = false;
               this.star22.visible = false;
               this.star23.visible = false;
               this.star24.visible = false;
               color = 1;
               if(ageBonus > 100)
               {
                  color = 2;
                  starBonus = starBonus - 100;
               }
               numStars = Math.round(starBonus / 20);
               i = 0;
               while(i < numStars)
               {
                  this["star" + color + "" + i].visible = true;
                  i++;
               }
               i = i;
               while(i < 5)
               {
                  this["star" + (color - 1) + "" + i].visible = true;
                  i++;
               }
               this.main_ctr.addContent(this.ctr_stars);
               if(data.collectSkill)
               {
                  collectInfos = this.jobsApi.getJobCollectSkillInfos(data.collectSkill.parentJob,data.collectSkill);
                  if(collectInfos.minResources == collectInfos.maxResources)
                  {
                     qty = collectInfos.maxResources;
                     bonus = qty * ageBonus / 100;
                     if(ageBonus % 100 == 0)
                     {
                        minResources = maxResources = qty + bonus;
                     }
                     else
                     {
                        minResources = bonus > qty?Math.ceil(bonus):qty;
                        maxResources = Math.ceil(qty + bonus);
                     }
                  }
                  else
                  {
                     minResources = collectInfos.minResources + collectInfos.minResources * ageBonus / 100;
                     maxResources = Math.ceil(collectInfos.maxResources + collectInfos.maxResources * ageBonus / 100);
                  }
                  if(minResources != maxResources)
                  {
                     this.lbl_resources_qty.text = minResources + " " + this.uiApi.getText("ui.chat.to") + " " + maxResources;
                  }
                  else
                  {
                     this.lbl_resources_qty.text = maxResources.toString();
                  }
                  this.lbl_resources_qty.y = this.ctr_stars.y + this.ctr_stars.contentHeight;
                  this.ctr_line.y = this.lbl_resources_qty.y + this.lbl_resources_qty.contentHeight + MARGIN;
                  this.main_ctr.addContent(this.lbl_resources_qty);
                  this.lbl_resources_qty.fullWidth();
               }
               else
               {
                  this.ctr_line.y = this.ctr_stars.y + this.ctr_stars.contentHeight + MARGIN;
               }
               disabledSkillsY = this.ctr_line.y + MARGIN;
               if(this.lbl_enabledSkills.visible)
               {
                  this.lbl_enabledSkills.y = this.ctr_line.y + MARGIN;
                  disabledSkillsY = this.lbl_enabledSkills.y + this.lbl_enabledSkills.contentHeight;
               }
               this.lbl_disabledSkills.y = disabledSkillsY;
               if(this.lbl_enabledSkills.visible)
               {
                  this.lbl_enabledSkills.fullWidth();
               }
               this.lbl_disabledSkills.fullWidth();
               maxWidth = this.getMaxWidth();
               if(data.collectSkill)
               {
                  this.lbl_resources_qty.x = (maxWidth - this.lbl_resources_qty.width) / 2 + 5;
               }
               this.ctr_stars.x = (maxWidth - this.ctr_stars.width) / 2 + 5;
            }
         }
         this.main_ctr.addContent(this.ctr_elementName);
         if(this.lbl_elementName.width > maxWidth)
         {
            maxWidth = this.lbl_elementName.width;
         }
         this.ctr_elementName.width = maxWidth;
         this.main_ctr.width = maxWidth;
         if(data.isCollectable)
         {
            this.lbl_elementName.x = (maxWidth - this.lbl_elementName.width) / 2;
         }
         this.ctr_line.width = maxWidth;
         this.ctr_line.x = (maxWidth - this.ctr_line.width) / 2 + 5;
         this.uiApi.me().render();
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset);
      }
      
      private function getMaxWidth() : Number {
         var maxWidth:* = NaN;
         if((this.lbl_elementName.width > this.ctr_stars.width) && (this.lbl_elementName.width > this.lbl_resources_qty.width))
         {
            maxWidth = this.lbl_elementName.width;
         }
         else if((this.ctr_stars.width > this.lbl_elementName.width) && (this.ctr_stars.width > this.lbl_resources_qty.width))
         {
            maxWidth = this.ctr_stars.width;
         }
         else if((this.lbl_resources_qty.width > this.ctr_stars.width) && (this.lbl_resources_qty.width > this.lbl_elementName.width))
         {
            maxWidth = this.lbl_resources_qty.width;
         }
         
         
         if((this.lbl_enabledSkills.visible) && (this.lbl_enabledSkills.width > maxWidth))
         {
            maxWidth = this.lbl_enabledSkills.width;
         }
         if(this.lbl_disabledSkills.width > maxWidth)
         {
            maxWidth = this.lbl_disabledSkills.width;
         }
         return maxWidth;
      }
      
      public function unload() : void {
      }
   }
}
