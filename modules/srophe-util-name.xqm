xquery version "3.0";
module namespace sutil="http://srophe.org/ns/srophe-util";

declare namespace tei="http://www.tei-c.org/ns/1.0";

(:~
 : Add alternate names for improved searching triggered when document is uploaded. 
:)
declare function sutil:left-half-ring-pers($recs){
    for $rec in $recs[descendant::tei:person/tei:persName[contains(.,'ʿ')]]
    let $parent := $rec/descendant::tei:person
    let $rec-id := substring-after($parent/@xml:id,'-')
    return 
        for $names in $parent/tei:persName[contains(.,'ʿ')]
        let $pers-name := string-join($names/node(),' ')
        let $new-name := 
            (
                <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 1))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','')}</persName>,
                <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 2))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','‘')}</persName>
            )
        return 
            if($parent/tei:persName[@syriaca-tags="#syriaca-simplified-script"]) then 
                if($parent/tei:persName[@syriaca-tags="#syriaca-simplified-script"]/text() = replace($pers-name,'ʿ','')) then ()
                else (update insert $new-name following $parent/tei:persName[last()],sutil:do-change-stmt($rec))
            else
                (update insert $new-name following $parent/tei:persName[last()],sutil:do-change-stmt($rec))
};

declare function sutil:right-half-ring-pers($recs){
    for $rec in $recs[descendant::tei:person/tei:persName[contains(.,'ʾ')]]
    let $parent := $rec/descendant::tei:person
    let $rec-id := substring-after($parent/@xml:id,'-')
    return 
        for $names in $parent/tei:persName[contains(.,'ʾ')]
        let $pers-name := string-join($names/node(),' ')
        let $new-name := 
            (
                <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 1))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','')}</persName>,
                <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 2))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','’')}</persName>
            )
        return 
            if($parent/tei:persName[@syriaca-tags="#syriaca-simplified-script"]) then 
                if($parent/tei:persName[@syriaca-tags="#syriaca-simplified-script"]/text() = replace($pers-name,'ʾ','')) then ()
                else (update insert $new-name following $parent/tei:persName[last()],sutil:do-change-stmt($rec))
            else
                (update insert $new-name following $parent/tei:persName[last()],sutil:do-change-stmt($rec))
};


declare function sutil:left-half-ring-place($recs){
    for $rec in $recs[descendant::tei:place/tei:placeName[contains(.,'ʿ')]]
    let $parent := $rec/descendant::tei:place
    let $rec-id := substring-after($parent/@xml:id,'-')
    return 
        for $names in $parent/tei:placeName[contains(.,'ʿ')]
        let $place-name := $names/text()
        let $new-name := 
            (
                <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 1))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','')}</placeName>,
                <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 2))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','‘')}</placeName>
            )
        return 
             if($parent/tei:placeName[@syriaca-tags="#syriaca-simplified-script"]) then 
                 if($parent/tei:placeName[@syriaca-tags="#syriaca-simplified-script"]/text() = replace($place-name,'ʿ','')) then ()
                 else
                     (update insert $new-name following $parent/tei:placeName[last()],sutil:do-change-stmt($rec))
             else
                (update insert $new-name following $parent/tei:placeName[last()],sutil:do-change-stmt($rec))
};

declare function sutil:right-half-ring-place($recs){
    for $rec in $recs[descendant::tei:place/tei:placeName[contains(.,'ʾ')]]
    let $parent := $rec/descendant::tei:place
    let $rec-id := substring-after($parent/@xml:id,'-')    
    return 
        for $names in $recs//tei:placeName[contains(.,'ʾ')]
        let $place-name := $names/text()
        let $new-name := 
            (
                <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 1))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','')}</placeName>,
                <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 2))}" xml:lang="en-x-srp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','’')}</placeName>
            )
        return 
            if($parent/tei:placeName[@syriaca-tags="#syriaca-simplified-script"]) then 
                if($parent/tei:placeName[@syriaca-tags="#syriaca-simplified-script"]/text() = replace($place-name,'ʿ','')) then ()
                else
                    (update insert $new-name following $parent/tei:placeName[last()],sutil:do-change-stmt($rec))
            else
               (update insert $new-name following $parent/tei:placeName[last()],sutil:do-change-stmt($rec))
};

declare function sutil:do-change-stmt($rec){
    let $change := 
        <change xmlns="http://www.tei-c.org/ns/1.0" who="http://syriaca.org/documentation/editors.xml#wsalesky" when="{current-date()}">Updated: Updated alternate names for search functionality, corrects bug in https://github.com/srophe/srophe-eXist-app/issues/874.</change>
    return
        (
         update insert $change preceding $rec/descendant::tei:teiHeader/tei:revisionDesc/tei:change[1],
         update value $rec/descendant::tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date with current-date())
};

declare function sutil:run-script-stmt($uri){
    let $recs :=     
        if(ends-with($uri, '.xml')) then doc($uri)/child::*
        else 
            for $docs in collection($uri)
            return $docs
    return             
        (
            sutil:left-half-ring-pers($recs),
            sutil:right-half-ring-pers($recs),
            sutil:left-half-ring-place($recs),
            sutil:right-half-ring-place($recs)
        )
};
