package com.ankamagames.dofus.datacenter.documents
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Document extends Object implements IDataCenter
    {
        public var id:int;
        public var typeId:uint;
        public var titleId:uint;
        public var authorId:uint;
        public var subTitleId:uint;
        public var contentId:uint;
        public var contentCSS:String;
        private var _title:String;
        private var _author:String;
        private var _subTitle:String;
        private var _content:String;
        private var _pages:Array;
        private static const MODULE:String = "Documents";
        private static const PAGEFEED:String = "<pagefeed/>";

        public function Document()
        {
            return;
        }// end function

        public function get title() : String
        {
            if (!this._title)
            {
                this._title = I18n.getText(this.titleId);
            }
            return this._title;
        }// end function

        public function get author() : String
        {
            if (!this._author)
            {
                this._author = I18n.getText(this.authorId);
            }
            return this._author;
        }// end function

        public function get subTitle() : String
        {
            if (!this._subTitle)
            {
                this._subTitle = I18n.getText(this.subTitleId);
                if (this._subTitle.charAt(0) == "[")
                {
                    this._subTitle = "";
                }
            }
            return this._subTitle;
        }// end function

        public function get content() : String
        {
            if (!this._content)
            {
                this._content = I18n.getText(this.contentId);
            }
            return this._content;
        }// end function

        public function get pages() : Array
        {
            if (!this._pages)
            {
                this._pages = this.content.split(PAGEFEED);
            }
            return this._pages;
        }// end function

        public static function getDocumentById(param1:int) : Document
        {
            return GameData.getObject(MODULE, param1) as Document;
        }// end function

        public static function getDocuments() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
