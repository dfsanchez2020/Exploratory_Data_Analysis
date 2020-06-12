## Cargando y preprocesando los datos

## Descargando el archivo y descomprimiento en el directorio de trabajo actual
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile=paste0(getwd(),"/Power_consumption.zip"),method = "curl")
unzip("Power_consumption.zip",exdir="./")

## Lea las primeras 5 filas para obtener encabezados
initial<-read.table("household_power_consumption.txt", header=TRUE,sep=";", nrows=5)

## Lea las 2900 filas que contienen información sobre 2007-02-01 y 2007-02-02
hpc<-read.table("household_power_consumption.txt", header=TRUE,sep=";", skip=66630, 
                nrows=2900, col.names=names(initial), na.strings=c("?"),
                colClasses=c("character", "character","numeric","numeric","numeric","numeric",
                             "numeric","numeric","numeric"))

## Conversión de variables de fecha y hora al formato de fecha/hora
hpc$Date<-as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time<-strptime(paste(hpc$Date,hpc$Time),"%F %T")

## Subconjunto de datos cargados para 2007-02-01 y 2007-02-02

hpc<-subset(hpc,hpc$Date %in% as.Date(c("2007-02-01","2007-02-02")))

# Creando plots
## El objetivo general aquí es examinar cómo el uso de energía del hogar varía durante un período de 2 días en febrero de 2007. Cada plot se recrea por segunda vez para guardarla en un archivo png sin que la función dev.copy () la corrompa.

## Plot 1. Histograma de consumo global de energía activa
par(mfrow=c(1,1),mar=c(5,4.5,4,2))
hist(hpc$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

png("plot1.png", width=480, height=480)
par(mfrow=c(1,1),mar=c(5,4.5,4,2))
hist(hpc$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()


## Plot 2. Consumo global de pobreza activa a lo largo del tiempo
par(mfrow=c(1,1),mar=c(5,4.5,4,2))
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")

png("plot2.png", width=480, height=480)
par(mfrow=c(1,1),mar=c(5,4.5,4,2))
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
dev.off()


## Plot 3. Submediciones de energía
par(mfrow=c(1,1),mar=c(4,4,4,2))
plot(hpc$Time,hpc$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time,hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time,hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[,7:9]))

png("plot3.png", width=480, height=480)
par(mfrow=c(1,1),mar=c(4,4,4,2))
plot(hpc$Time,hpc$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time,hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time,hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[,7:9]))
dev.off()


## Plot 4. Combinación de 4 parcelas: potencia activa global, submediciones de energía, voltaje en el tiempo, potencia reactiva global en el tiempo
par(mfcol=c(2,2), mar=c(4.5,5,2,2))
# Plot 4.1
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
# Plot 4.2
plot(hpc$Time,hpc$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time,hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time,hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[,7:9]), bty="n")
# Plot 4.3
plot(hpc$Time,hpc$Voltage, ylab="Voltage", xlab="datetime", type="l")
# Plot 4.4
plot(hpc$Time,hpc$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")

png("plot4.png", width=480, height=480)
par(mfcol=c(2,2), mar=c(4.5,5,2,2))
# Plot 4.1
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
# Plot 4.2
plot(hpc$Time,hpc$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time,hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time,hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[,7:9]), bty="n")
# Plot 4.3
plot(hpc$Time,hpc$Voltage, ylab="Voltage", xlab="datetime", type="l")
# Plot 4.4
plot(hpc$Time,hpc$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
dev.off()
