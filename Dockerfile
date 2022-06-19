FROM java:8
EXPOSE 8088
ADD target/timesheet-4.3.jar timesheet-4.3.jar
ENTRYPOINT ["java", "-jar", "/timesheet-4.3.jar ]