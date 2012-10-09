
package org.pih.warehouse.pages

import geb.Page
import testutils.Settings

class LocationPage extends  Page{
    static url = Settings.baseUrl + "/dashboard/chooseLocation"
    static at = { title == "Choose a location"}
    static content ={
        boston(to: DashboardPage) { $("#warehouse-1-link")}
        miami(to: DashboardPage) { $("#warehouse-2-link")}
        tabarre(to: DashboardPage) { $("#warehouse-3-link")}
    }
}