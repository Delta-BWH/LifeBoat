<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="geo-res">

        <folder name="res">
            <folder path="geoservicedemo/res/drawable"/>
            <folder path="geoservicedemo/res/layout"/>
            <folder name="values">
                <file path="geoservicedemo/res/values/dimens.xml"/>
                <file path="geoservicedemo/res/values/string_arrays.xml"/>
                <file name="strings.xml">&lt;?xml version="1.0" encoding="utf-8"?&gt;

&lt;resources&gt;
    &lt;string name="app_name"&gt;<xsl:value-of select="$projectName"/>&lt;/string&gt;
    &lt;string name="browsing_category_page_title"&gt;Browsing category: %s&lt;/string&gt;
    &lt;string name="default_browsing_category_page_title"&gt;Browsing selected category&lt;/string&gt;
    &lt;string name="edit_query_field_hint"&gt;Enter the query here&lt;/string&gt;
    &lt;string name="query_prompt"&gt;Query:&lt;/string&gt;
    &lt;string name="edit_button_text"&gt;Edit&lt;/string&gt;
    &lt;string name="search_in_prompt"&gt;Search in:&lt;/string&gt;
    &lt;string name="map_boundaries_text"&gt;Map Boundaries&lt;/string&gt;
    &lt;string name="radius_text"&gt;Radius&lt;/string&gt;
    &lt;string name="initial_radius"&gt;10&lt;/string&gt;
    &lt;string name="clear_filter_button_text"&gt;Clear Filter&lt;/string&gt;
    &lt;string name="apply_filter_button_text"&gt;Apply Filter&lt;/string&gt;
    &lt;string name="select_category_prompt"&gt;Select a category:&lt;/string&gt;
    &lt;string name="list_item_arrow"&gt;list item arrow&lt;/string&gt;
    &lt;string name="filter_button_text"&gt;Filter&lt;/string&gt;
    &lt;string name="show_on_map_button_text"&gt;Show on map&lt;/string&gt;
    &lt;string name="show_as_text_button_text"&gt;Show as text&lt;/string&gt;
    &lt;string name="next_symbol"&gt;&lt;![CDATA[&gt;&gt;]]&gt;&lt;/string&gt;
    &lt;string name="previous_symbol"&gt;&lt;![CDATA[&lt;&lt;]]&gt;&lt;/string&gt;
    &lt;string name="geo_points_text_list_item_template"&gt;%1$d. Lat: %2$s, Lon: %3$s&lt;/string&gt;
    &lt;string name="list_row_arrow_description"&gt;list row arrow&lt;/string&gt;
&lt;/resources&gt;
                                </file>
                            </folder>
                        </folder>

    </xsl:template>

</xsl:stylesheet>