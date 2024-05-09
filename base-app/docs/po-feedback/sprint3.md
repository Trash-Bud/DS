# PO Feedback

Overall, positive feedback from PO. However, not having the integration of the design system with the microservices and all deployed in production (because of the ceasing of the minutes of the GitHub actions) were negative points for the PO.

## Common:
- Demonstration in production
- Establish a design system for frontend consitency and integration with microservices
    - Colors (use Brand-Configs as example)
    - Fontsize
    - Buttons
    - Listing
    - Input fields
    - Pagination
- Login integration with all microservices
    - Only admin has acess to Brand-Configs
    - Differents app views according to brand signed in
        - Each brand can oly access its items (Inbound + Catalog)
- Set up early demo of frontend (with design system)

## Catalog:
- Integration with login
    - Brands dropdown is not shown when its a brand logged in

## Inbound:
- POs and ASNs pagination
- Inside POs, ASNs do not need pagination
- Proposed feature: 
    - PO/ASN edition (but not a priority: not so important as what was mentioned in the Common's section above) 
    - Items Re-upload 

## Brand Configs:
- If brand logged in, it has no access to the Brand Config (Important)
- Good design, very similar to the given mockups by MAERSK. And for that reason, use colors used as reference for the design system
- Complete Return tab
- No other tabs needed
- Proposed feature: 
    - Edit brand (more important than PO/ASN edition)

## KAKFA
- Integration with inbound
- Set up early demo to show KAFKA working
