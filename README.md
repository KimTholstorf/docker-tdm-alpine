![TAM][logo]
# VMware TAM Data Manager (TDM)
#### Docker version 
This version is not affiliated with or endorsed by the VMware Professional Services Tools team, who maintain and builds the official version.
***Is to be used at your own risk.*** The intend is to have a Docker alternative to the official Java and OVA builds.

Latest TDM release is 2.1.7 and this Docker image is based on that TDM version.

#### TDM Introduction
The TAM Data Manager / TAM Data Collector gathers key statistics, deployed product licenses and usage information from VMware virtual infrastructure and VMware Horizon View deployments to be sent to and analyzed by the VMware TAM team as well as the VMware Phone Home Customer Intelligence team.

Customers can install the TAM Data Collector to collect usage data. Customers collect data, export the project file, and provide it to VMware Technical Account Managers (TAMs) in person or by email. If the customer agrees to send data to VMware in the initial customer agreement, then data is sent to the VMware Phone Home network by the TAM at a later stage of the TDM process.

##### Intended users
This product is solely intended for 
- VMware Technical Account Managers (TAM)
- VMware System Enineers (SE) for [DICE Customer Models](http://dicevm.com)
- VMware customers who have a current TAM service subscription (TDM in Collector mode)
*Are you not a VMware TAM customer or VMware TAM or SE there is no way for you to get any use out of this tool*
[Click here to read more about what a VMware echnical Account Manager can bring to your orginization] (https://www.vmware.com/professional-services/optimization-advocacy.html)

##### Security

| Port | Protocol | Discription |  |
| ------ | ------ | ------ | ------ |
| ~~22~~ | ~~SSH~~ | ~~Inbound TCP port that is used by an administrator to log in to the TAM Data Collector virtual appliance to perform maintenance tasks. This port is not used by the TAM Data Manager application.~~ | Not applicable for the Docker version  |
| 433 | HTTPS | Outbound TCP port that is used by TAM Data Collector to retrieve data from the vCenter Server and the Horizon View Connection broker. This port is specified when configuring TAM Data Collector to retrieve data and might be different depending on the environment. |  |
| 8080 | HTTP | Inbound TCP port that is used by the TAM Data Collector user interface. |  |
| 80 and 8080 | HTTP | Both inbound TCP ports are used by the TAM Data Collector virtual appliance user interface. |  |
| 8443 | HTTPS | Inbound TCP Port to access the TAM Data Collector virtual appliance user interface | Only this need to be exposed in Docker version |
| 41984 |  | Port used for the TAM Data Collector database. | Internal use only. Not default exposed in the Docker version  |
| 41985 |  | Port used for TAM Data Collector database event service. | Internal use only. Not default exposed in the Docker version  |
| ~~5480~~ | ~~HTTPS~~ | ~~Inbound TCP port used to access the TAM Data Collector virtual appliance management Web interface from a browser.~~ | Not applicable for the Docker version  |

##### Working with TAM Data Collector
See section 3 in the [TDM 2.1.7 Collector Install and User Guide](http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/vmware_tam_data_collector_user_guide.pdf) on how to collect and export data.

## Docker image version

*Next step in this project is to make this image availble from dockerhub to eliminate the need for anyone to build the image itself*
But for now:
```sh
docker build -t kimtholstorf/tdm .
```
run the image with port 8443 exposed
```sh
docker run -d -p 8443:8443 kimtholstorf/tdm
```
Verify the deployment by navigating to your server address in your preferred browser.

```sh
https://$(docker_host):8443/web/index.html
https://localhost:8443/web/index.html
```

## Official VMware version
#### Downloads
- [TDM 2.1.7 OVA Build](http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/GA/tdm-PRODUCTION-2.1.7.0-9468226_OVF10.ova)
- [TDM 2.1.7 JAVA Build](http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/GA/tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip)
- [TDM 2.1.7 upgrade tool](http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/GA/tdm-2.1.7-GA-upgrade-tool-9468226-PRODUCTION.jar)
#### Documentation
- [TDM 2.1.7 Collector Install and User Guide](http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/vmware_tam_data_collector_user_guide.pdf)


[logo]: https://blogs.vmware.com/services-education-insights/files/2017/02/TAM_Medium.jpg